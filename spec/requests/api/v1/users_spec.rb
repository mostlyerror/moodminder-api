require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'POST /api/v1/users' do
    let(:valid_attributes) do
      {
        user: {
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          first_name: 'John',
          last_name: 'Doe',
          phone_number: '+15551234567'
        }
      }
    end

    context 'with valid parameters' do
      before { post '/api/v1/users', params: valid_attributes }

      it 'returns 201 status code' do
        expect(response).to have_http_status(:created)
      end

      it 'creates a new user' do
        expect(User.count).to eq(1)
      end

      it 'returns JWT token' do
        expect(json_response['token']).to be_present
      end

      it 'returns user information' do
        expect(json_response['user']['email']).to eq('test@example.com')
      end
    end

    context 'with invalid parameters' do
      before { post '/api/v1/users', params: { user: { email: 'invalid' } } }

      it 'returns 422 status code' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns validation errors' do
        expect(json_response['errors']).to be_present
      end
    end
  end
end 