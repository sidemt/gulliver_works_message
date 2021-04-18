# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EnterpriseAuth::V1::AuthController, type: :request do
  describe 'POST /enterprise_auth/v1/sign_in' do
    let(:request) { post enterprise_auth_v1_sign_in_path, params: params }
    let(:employee) { create(:employee) }
    let(:params) do
      { employee: { email: employee.email, password: employee.password } }
    end

    it '正常にサインアップできること' do
      expect { request }.to change { Jti.count }.by(+1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /enterprise_auth/v1/sign_up' do
    let(:request) { post enterprise_auth_v1_sign_up_path, params: params }
    let(:employee) { build(:employee) }
    let(:company) { create(:company) }
    let(:params) do
      { employee: { email: employee.email, password: employee.password, company_id: company.id } }
    end

    it '正常にサインアップできること' do
      expect { request }.to change { Employee.count }.by(+1)
      expect(response).to have_http_status(:created)
    end
  end
end
