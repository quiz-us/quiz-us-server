# frozen_string_literal: true

require 'aws-sdk-s3'

# CreateQuestion processes a question and all of its associated objects (ie.
# tags and question_options), and then creates them.
class CreateQuestionService
  class UnprocessableImageError < StandardError; end
  include Callable

  def initialize(params)
    @rich_text = params[:rich_text]
    @question_options = params[:question_options]
    @question_plaintext = params[:question_plaintext]
    @question_standard_id = params[:standard_id]
    @question_type = params[:question_type]
    @tags = params[:tags]
    @teacher_id = params[:teacher_id]
    @s3 = Aws::S3::Resource.new(region: 'us-west-2')
  end

  def call
    # TODO: handle errors from this transaction
    ActiveRecord::Base.transaction do
      @question = create_question!
      create_tags!
      map_question_to_standards!
      create_question_options!
      @question
    end
  end

  private

  def create_question!
    # if there are images, then take the data:image blobs, temporarily download
    # them, upload the file to s3, and then save that s3 url under the question's
    # rich_text
    rich_text = process_images!(@rich_text)
    Question.create!(
      rich_text: rich_text,
      question_text: @question_plaintext,
      question_type: @question_type
    )
  end

  def process_images!(rich_text)
    rich = JSON.parse(rich_text)
    nodes = rich['document']['nodes'].map do |node|
      node['data']['file'] = upload_to_s3(node) if node['type'] == 'image'
      node
    end
    rich['document']['nodes'] = nodes
    rich.to_json
  end

  def upload_to_s3(node)
    data_url = node['data']['file']

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

    # File.open(open(url), 'rb') { |file| obj.put(body: file) }
    obj = @s3.bucket(bucket_name).object(s3_file_name)
    obj.upload_file(path, acl: 'public-read')
    File.delete(path) if File.exist?(path)
    obj.public_url
  end

  def create_tags!
    @tags.each do |tag_name|
      tag = Tag.find_or_create_by!(name: tag_name)
      @question.taggings.create!(tag_id: tag.id)
    end
  end

  def map_question_to_standards!
    @question.questions_standards.create(
      standard_id: @question_standard_id
    )
  end

  def create_question_options!
    num_answer_choices = @question_options.length
    @question_options.each do |option|
      option_obj = JSON.parse(option)
      rich_text = process_images!(option_obj['richText'].to_json)
      @question.question_options.create!(
        # if it's free response and has only once answer choice,
        # then correct should always default to true:
        correct: num_answer_choices == 1 || option_obj['correct'],
        rich_text: rich_text,
        option_text: option_obj['optionText']
      )
    end
  end
end
