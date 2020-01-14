# frozen_string_literal: true

require 'active_support/concern'
require 'aws-sdk-s3'

module ImageS3Processable
  extend ActiveSupport::Concern
  # if there are images, then take the data:image blobs, temporarily download
  # them, upload the file to s3, and then save that s3 url under the question's
  class UnprocessableImageError < StandardError;
  end

  def process_images!(rich_text)
    rich = rich_text.class == Hash ? rich_text : JSON.parse(rich_text)
    nodes = rich['document']['nodes'].map do |node|
      node['data']['file'] = upload_to_s3(node) if node['type'] == 'image'
      node
    end
    rich['document']['nodes'] = nodes
    rich.to_json
  end

  def upload_to_s3(node)
    @s3 = Aws::S3::Resource.new(region: 'us-west-2')

    data_url = node['data']['file']
    return data_url if data_url.start_with?('http')

    regexp = %r{\Adata:([-\w]+/[-\w\+\.]+)?;base64,(.*)}m

    data_uri_parts = data_url.match(regexp) || []
    extensions = MIME::Types[data_uri_parts[1]]
    raise UnprocessableImageError if extensions.empty?

    extension = extensions.first.preferred_extension
    file_name = "#{SecureRandom.hex(8)}.#{extension}"
    s3_file_name = "teachers/#{@teacher_id}/#{file_name}"

    path = "tmp/#{file_name}"

    File.open(path, 'wb') do |file|
      file.write(Base64.decode64(data_uri_parts[2]))
    end

    bucket_name = Rails.env.production? ? 'quizus' : 'quizus-staging'

    obj = @s3.bucket(bucket_name).object(s3_file_name)
    obj.upload_file(path, acl: 'public-read')
    File.delete(path) if File.exist?(path)
    obj.public_url
  end
end
