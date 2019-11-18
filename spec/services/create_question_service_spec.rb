# frozen_string_literal: true

require 'rails_helper'
require 'aws-sdk-s3'

RSpec.describe CreateQuestionService do
  let(:s3) { double('s3') }
  let(:obj) { double('s3_obj') }
  let(:dummy_s3_url) { 'https://example.s3.com' }
  let(:rich_text_with_image) do
    lambda do |filename|
      {
        object: 'value',
        document: {
          object: 'document',
          data: {},
          nodes: [
            {
              object: 'block',
              type: 'image',
              data: {
                file: filename
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
      }
    end
  end
  let(:params_with_unprocessable_images) do
    { rich_text: rich_text_with_image['bad-base64-image'].to_json }
  end
  let(:params_with_images) do
    {
      rich_text: rich_text_with_image['data:image/png;base64,abc'].to_json,
      question_options: [{
        richText: rich_text_with_image['data:image/png;base64,def'],
        optionText: '',
        correct: true
      }.to_json],
      question_plaintext: 'abc',
      question_standard_id: 1,
      question_type: 'Free Response',
      tags: %w[test ok]
    }
  end

  before(:each) do
    allow(Aws::S3::Resource).to receive(:new).and_return(s3)
    allow(s3).to receive_message_chain(:bucket, :object).and_return(obj)
    allow(obj).to receive(:upload_file).and_return(true)
    allow(obj).to receive(:public_url).and_return(dummy_s3_url)
  end

  context 'when creating the question' do
    context 'when the question has images' do
      it 'throws UnprocessableImageError when base 64 encoding is invalid' do
        expect do
          CreateQuestionService.new(params_with_unprocessable_images).call
        end.to raise_error(ImageS3Processable::UnprocessableImageError)
      end
      it 'downloads the base64 image encoding and uploads the image to s3' do
        CreateQuestionService.new(params_with_images).call
        JSON.parse(Question.last.rich_text)['document']['nodes'].each do |node|
          expect(node['data']['file']).to eq(dummy_s3_url) if node['type'] == 'image'
        end
      end
    end
  end
end
