require 'swagger_helper'

def decoded_jwt_token_from_response(response)
  token_from_request = response.headers['Authorization'].split(' ').last
  JWT.decode(token_from_request, ENV['DEVISE_JWT_SECRET_KEY'], true)
end

describe 'Teacher Sessions API', type: :request, swagger_doc: 'v1/swagger.json' do
  path '/teachers/sign_in' do
    let(:email) { Faker::Internet.email }
    before do
      create(:teacher, email: email, password: 'password')
    end
    post 'Signs teacher in' do
      tags 'Teacher Sign In'
      consumes 'application/json'
      produces 'application/json'
      parameter in: :body, schema: {
        type: :object,
        properties: {
          teacher: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            }
          }
        },
        required: ['email', 'password']
      }
      response '200', 'Success: User signed in' do
        let(:params) { { teacher: { email: email, password: 'password' } } }
        before do
          post '/teachers/sign_in', params: params
        end

        it 'returns a valid 200 response' do
          expect(response.status).to eq 200
        end

        it 'returns JTW token in authorization header' do
          expect(response.headers['Authorization']).to be_present
        end

        it 'returns valid JWT token' do
          decoded_token = decoded_jwt_token_from_response(response)
          expect(decoded_token.first['sub']).to be_present
        end
      end

      response '401', 'Unauthorized: invalid sign in credentials' do
        let(:teacher) { { teacher: { email: 'rando@example.com', password: '123'} } }
        run_test!
      end
    end
  end

  path '/teachers/sign_out' do
    delete 'Signs teacher out' do
      tags 'Teacher Sign Out'
      consumes 'application/json'
      produces 'application/json'
      response '204', 'No content returned: Teacher has been signed out' do
        before do
          delete '/teachers/sign_out'
        end

        it 'returns a valid 204 response' do
          expect(response.status).to eq 204
        end
      end
    end
  end
end
