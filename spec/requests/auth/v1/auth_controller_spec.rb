# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Auth::V1::AuthController, type: :request do
  describe 'POST /auth/v1/sign_in' do
    let(:request) { post auth_v1_sign_in_path, params: params }
    let(:account) { create(:account) }
    let(:params) do
      { account: { email: account.email, password: account.password } }
    end

    it '正常にサインアップできること' do
      expect { request }.to change { Jti.count }.by(+1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /auth/v1/sign_up' do
    let(:request) { post auth_v1_sign_up_path, params: params }
    let(:account) { build(:account) }
    let(:params) do
      { account: { email: account.email, password: account.password } }
    end

    it '正常にサインアップできること' do
      expect { request }.to change { Account.count }.by(+1)
      expect(response).to have_http_status(:created)
    end
  end
end
