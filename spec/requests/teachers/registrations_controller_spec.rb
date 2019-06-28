require 'swagger_helper'

describe 'Teacher Registrations API', type: :request, swagger_doc: 'v1/swagger.json' do
  path '/teachers' do
    post 'Registers a new teacher' do
      tags 'Teacher Registration'
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

      let(:params) do
        {
          teacher: {
            email: Faker::Internet.email,
            password: 'password'
          }
        }
      end
      context 'when teacher is unauthenticated' do
        response '200', 'Success' do
          before do
            post '/teachers', params: params
          end

          it 'returns a valid 200 response' do
            expect(response.status).to eq 200
          end

          it 'returns a new teacher' do
            expect(response.body).to include('id', 'email')
          end
        end
      end

      context 'when teacher already exists' do
        response '400', 'Bad Request' do
          before do
            create(:teacher, email: params[:teacher][:email])
            post '/teachers', params: params
          end

          it 'returns bad request status' do
            expect(response.status).to eq 400
          end
        end
      end
    end
  end
end
