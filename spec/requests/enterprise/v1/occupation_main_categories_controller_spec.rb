# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Enterprise::V1::OccupationMainCategoriesController, type: :request do
  let(:employee) { create(:employee) }
  let(:headers) { { Authorization: "Bearer #{employee.jwt}" } }

  describe 'GET /enterprise/v1/occupation_main_categories' do
    let(:request) { get enterprise_v1_occupation_main_categories_path, headers: headers }
    let!(:occupations) { create(:occupation) }

    it '職種一覧（大中小全て含めて）を取得できる' do
      request
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      occupation_main_category = parsed_body['occupation_main_categories'].first
      expect(occupation_main_category.keys).to include('name')
      expect(occupation_main_category['occupation_sub_categories'].first.keys).to include('name')
      expect(occupation_main_category['occupation_sub_categories'].first['occupations'].first.keys).to include('name')
    end
  end
end
