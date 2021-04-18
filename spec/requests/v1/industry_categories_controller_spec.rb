# frozen_string_literal: true
require 'rails_helper'

RSpec.describe V1::IndustryCategoriesController, type: :request do
  let(:account) { create(:account) }
  let(:headers) { { Authorization: "Bearer #{account.jwt}" } }

  describe 'GET /v1/industry_categories' do
    let(:request) { get v1_industry_categories_path, headers: headers }
    let!(:industries) { create(:industry) }

    it '業種一覧を取得できる' do
      request
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      industry_categories = parsed_body['industry_categories']
      expect(industry_categories.size).to eq IndustryCategory.count
      industry_category = industry_categories.first
      expect(industry_category.keys).to include('name', 'industries')
      expect(industry_category['industries'].first.keys).to include('name')
    end
  end
end
