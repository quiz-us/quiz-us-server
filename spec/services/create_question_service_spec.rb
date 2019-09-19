# frozen_string_literal: true

require 'rails_helper'
require 'aws-sdk-s3'

RSpec.describe CreateQuestionService do
  let(:s3) { double('s3') }
  let(:params_with_images) do
    {
      rich_text: {
        object: 'value',
        document: {
          object: 'document',
          data: {},
          nodes: [
            {
              object: 'block',
              type: 'image',
              data: {
                file: 'base64-image'
              },
              nodes: [
                {
                  object: 'text',
                  text: ''
                }
              ]
            }
          ]
        }
      }.to_json,
      question_options: [{
        richText: {
          object: 'value',
          document: {
            object: 'document',
            data: {},
            nodes: [
              {
                object: 'block',
                type: 'image',
                data: {
                  file: 'base64-image'
                },
                nodes: [
                  {
                    object: 'text',
                    text: ''
                  }
                ]
              }
            ]
          }
        }.to_json,
        optionText: '',
        correct: true
      }.to_s],
      question_plaintext: 'abc',
      question_standard_id: 1,
      question_type: 'Free Response',
      tags: %w[test ok]
    }
  end

  before(:each) do
    Aws::S3::Resource.stub(:new) { s3 }
  end

  context 'when creating the question' do
    it 'downloads the base64 image encoding and uploads the image to s3' do
      CreateQuestionService.new(params_with_images)
    end
  end
end
