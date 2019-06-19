require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do
  let(:url) { '/teachers' }
  let(:params) do
    {
      teacher: {
        email: Faker::Internet.email,
        password: 'password'
      }
    }
  end

  context 'when teacher is unauthenticated' do
    before { post url, params: params }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns a new teacher' do
      teacher = JSON.parse(response.body)
      expect(teacher).to include('id', 'email')
    end
  end

  context 'when teacher already exists' do
    before do
      create(:teacher, email: params[:teacher][:email])
      post url, params: params
    end

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end
  end
end
