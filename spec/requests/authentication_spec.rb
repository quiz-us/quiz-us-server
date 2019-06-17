require 'rails_helper'

def decoded_jwt_token_from_response(response)
  token_from_request = response.headers['Authorization'].split(' ').last
  JWT.decode(token_from_request, ENV['DEVISE_JWT_SECRET_KEY'], true)
end

RSpec.describe 'GET /teachers/sign_in', type: :request do
  let(:teacher) { create(:teacher) }
  let(:url) { '/teachers/sign_in' }
  let(:params) do
    {
      teacher: {
        email: teacher.email,
        password: teacher.password
      }
    }
  end

  context 'when params are correct' do
    before do
      post url, params: params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns valid JWT token' do
      decoded_token = decoded_jwt_token_from_response(response)
      expect(decoded_token.first['sub']).to be_present
    end
  end

  context 'when login params are incorrect' do
    before { post url }

    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end
  end
end

RSpec.describe 'DELETE /teachers/sign_out', type: :request do
  let(:url) { '/teachers/sign_out' }

  before do
    delete url
  end

  it 'returns 204, no content' do
    expect(response).to have_http_status(204)
  end
end