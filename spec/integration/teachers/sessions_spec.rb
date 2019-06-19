require 'swagger_helper'

describe 'Sessions Tests API', type: :request, swagger_doc: 'v1/swagger.json' do
  path '/teachers/sign_in' do
    let(:email) { Faker::Internet.email }
    before do
      create(:teacher, email: email, password: 'password')
    end
    post 'Signs teacher in' do
      tags 'Teacher Sign In'
      operationId 'teacherSignIn'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :teacher, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }
      response '200', 'success' do
        let(:teacher) { { teacher: { email: email, password: 'password' } } }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:teacher) { { teacher: { email: 'rando@example.com', password: '123'} } }
        run_test!
      end
    end
  end
end
