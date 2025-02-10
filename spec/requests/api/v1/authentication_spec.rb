require 'rails_helper'

RSpec.describe 'Api::V1::Authentication', type: :request do
  describe 'POST /api/v1/login' do
    let(:user) { create(:user) }
    let(:valid_credentials) { { email: user.email, password: 'password123' } }
    let(:invalid_credentials) { { email: user.email, password: 'wrongpassword' } }

    context 'with valid credentials' do
      before { post '/api/v1/login', params: valid_credentials }

      it 'returns 200 status code' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns JWT token' do
        expect(json_response['token']).to be_present
      end

      it 'returns user information' do
        expect(json_response['user']['email']).to eq(user.email)
      end
    end

    context 'with invalid credentials' do
      before { post '/api/v1/login', params: invalid_credentials }

      it 'returns 401 status code' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns error message' do
        expect(json_response['error']).to be_present
      end
    end
  end
end
