# frozen_string_literal: true
require 'rails_helper'

RSpec.describe V1::AccountsController, type: :request do
  let!(:account) { create(:account) }
  let(:headers) { { Authorization: "Bearer #{account.jwt}" } }

  describe 'GET /v1/accounts' do
    subject(:request) { get v1_accounts_path, headers: headers }
    let!(:accounts) { create_list(:account, 10) }

    it 'アカウント一覧が取得できること' do
      request
      expect(response).to have_http_status(:ok)
      response_json = JSON.parse(response.body)
      expect(response_json['accounts'].count).to eq 11
    end
  end

  describe 'GET /v1/accounts/:id' do
    subject(:request) { get v1_account_path(account.id), headers: headers }

    it 'アカウントが取得できること' do
      request
      expect(response).to have_http_status(:ok)
      response_json = JSON.parse(response.body)
      expect(response_json['id']).to eq account.id
    end
  end

  describe 'DELETE /v1/accounts/:id' do
    subject(:request) { delete v1_account_path(account.id), headers: headers }

    it '削除できること' do
      expect { request }.to change(Account, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
