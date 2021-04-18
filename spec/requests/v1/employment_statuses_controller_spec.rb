# frozen_string_literal: true
require 'rails_helper'

RSpec.describe V1::EmploymentStatusesController, type: :request do
  let(:account) { create(:account) }
  let(:headers) { { Authorization: "Bearer #{account.jwt}" } }

  describe 'GET /v1/employment_statuses' do
    let(:request) { get v1_employment_statuses_path, headers: headers }
    let!(:employment_statuses) { create(:employment_status) }

    it '雇用形態一覧を取得できる' do
      request
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['employment_statuses'].size).to eq EmploymentStatus.count
    end
  end
end
