# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Enterprise::V1::CompaniesController, type: :request do
  let!(:employee) { create(:employee, company: company) }
  let(:company) { create(:company) }
  let(:headers) { { Authorization: "Bearer #{employee.jwt}" } }

  describe 'GET /enterprise/v1/companies' do
    subject(:request) { get enterprise_v1_companies_path, headers: headers }
    let!(:companies) { create_list(:company, 10) }

    it '企業一覧を取得できること' do
      request
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['companies'].length).to eq 11
    end
  end

  describe 'POST /enterprise/v1/companies' do
    subject(:request) { post enterprise_v1_companies_path, params: params, headers: headers }
    let(:params) do
      { company: attributes_for(:company) }
    end

    it '企業を作成できること' do
      expect { request }.to change(Company, :count).by(+1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET /enterprise/v1/companies/:id' do
    subject(:request) { get enterprise_v1_company_path(company.id), headers: headers }

    it '企業を取得できること' do
      request
      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['id']).to eq company.id
    end
  end

  describe 'PATCH /enterprise/v1/companies/:id' do
    subject(:request) do
      patch enterprise_v1_company_path(target_company.id), params: params, headers: headers
    end
    let(:params) { { company: { name: '新企業名' } } }

    context '所属している企業の場合' do
      let(:target_company) { company }

      it '企業を更新できること' do
        request
        expect(response).to have_http_status(:ok)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['name']).to eq('新企業名')
      end
    end

    context '所属していない企業の場合' do
      let(:target_company) { create(:company) }

      it '企業を更新できないこと' do
        request
        expect(response).to have_http_status(:forbidden)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['name']).not_to eq('新企業名')
      end
    end
  end

  describe 'DELETE /enterprise/v1/companies/:id' do
    subject(:request) { delete enterprise_v1_company_path(target_company.id), headers: headers }

    context '所属している企業の場合' do
      let!(:target_company) { company }

      it '企業を削除できること' do
        expect { request }.to change(Company, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context '所属していない企業の場合' do
      let!(:target_company) { create(:company) }

      it '企業を更新できないこと' do
        expect { request }.not_to change(Company, :count)
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
