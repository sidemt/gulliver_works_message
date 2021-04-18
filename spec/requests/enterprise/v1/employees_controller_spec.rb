# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Enterprise::V1::EmployeesController, type: :request do
  let!(:employee) { create(:employee) }
  let(:headers) { { Authorization: "Bearer #{employee.jwt}" } }

  describe 'GET /enterprise/v1/employees/:id' do
    subject(:request) { get enterprise_v1_employee_path(employee.id), headers: headers }

    it '従業員を取得できること' do
      request
      expect(response).to have_http_status(:ok)
      response_json = JSON.parse(response.body)
      expect(response_json['id']).to eq employee.id
    end
  end

  describe 'DELETE /enterprise/v1/employees/:id' do
    subject(:request) { delete enterprise_v1_employee_path(employee.id), headers: headers }

    it '従業員を削除できること' do
      expect { request }.to change(Employee, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
