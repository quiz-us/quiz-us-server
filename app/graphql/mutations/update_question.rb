# frozen_string_literal: true
require 'aws-sdk-s3'

module Mutations
  class UpdateQuestion < BaseMutation
    # include ImageS3Processing
    graphql_name 'Update Question'
    description 'Update Question'

    # arguments passed to the `resolved` method
    argument :id, ID, required: true
    argument :question_type, String, required: false
    argument :standard_id, ID, required: false
    argument :tags, [String], required: false
    argument :rich_text, String, required: false
    argument :question_plaintext, String, required: false
    argument :question_options, [String], required: false

    # return type from the mutation
    type Types::QuestionType

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

    # question_type: nil, 
    def resolve(
      id:,
      rich_text: nil,
      question_plaintext: nil,
      standard_id: nil,
      tags: [],
      question_options: []
    )
      @question = Question.find(id)
      @question.question_text = question_plaintext
      @question.rich_text = process_images!(rich_text)

      # update standards and tags associations
      @question.standards = [Standard.find(standard_id)] 
      @question.tags = tags.map { |tag| Tag.find_or_create_by(name: tag) }
      @question_options = question_options

      orphan_old_answer_choices
      update_answer_choices
      @question.save! #do we even need this?
      @question
    end

    private 

    def orphan_old_answer_choices
      # ex: [4, 5] - [5] = [4]
      oldQuestionOptionsIds = @question.question_options.pluck(:id)
      updatedQuestionOptionsIds = @question_options.map { |option| JSON.parse(option)['id'].to_i }
      deletedQuestionIds = oldQuestionOptionsIds - updatedQuestionOptionsIds

      deletedQuestionIds.each { |option_id| QuestionOption.find(option_id).update!(question_id: nil) }
    end

    def update_answer_choices
      num_answer_choices = @question_options.length
      @question_options.each do |option|
        option_obj = JSON.parse(option)
        rich_text = process_images!(option_obj['richText'].to_json)
        option_obj_id = option_obj['id']

        if option_obj_id
          question_option = QuestionOption.find(option_obj_id)
          question_option.update(
            correct: option_obj['correct'],
            rich_text: rich_text,
            option_text: option_obj['optionText']
          )
        else
          @question.question_options.create(
            correct: num_answer_choices == 1 || option_obj['correct'],
            rich_text: rich_text,
            option_text: option_obj['optionText']
          )
        end
      end
    end
  end
end
