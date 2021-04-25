# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Enterprise::V1::RoomsController, type: :request do
  # Company の準備
  let!(:company) { create(:company) }
  let!(:company2) { create(:company) }
  # Employee の準備
  let!(:employee) { create(:employee, company: company) }
  let(:headers_self) { { Authorization: "Bearer #{employee.jwt}" } }
  let!(:employee_other_company) { create(:employee, company: company2) }
  let(:headers_other) { { Authorization: "Bearer #{employee_other_company.jwt}" } }
  # Account の準備
  let!(:account) { create(:account) }
  let!(:account2) { create(:account) }
  # Room の準備
  let!(:room) { create(:room, account: account, company: company) }

  describe "GET /rooms/:id" do
    subject(:request) { get enterprise_v1_room_path(room.id), headers: auth_header }

    context '自社のトークルームの場合' do
      let(:auth_header) { headers_self }

      it 'トークルームが取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to eq room.id
      end
    end

    context '他社のトークルームの場合' do
      let(:auth_header) { headers_other }

      it 'トークルームが取得できないこと' do
        request
        expect(response).to have_http_status(:forbidden)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to be_nil
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it 'トークルームが取得できないこと' do
        request
        expect(response).to have_http_status(:unauthorized)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to be_nil
      end
    end
  end

  describe "GET /companies/:company_id/rooms" do
    subject(:request) { get enterprise_v1_company_rooms_path(company.id), headers: auth_header }

    context '自社のトークルームの場合' do
      let(:auth_header) { headers_self }

      it 'トークルームの一覧が取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['rooms'].size).to eq company.rooms.count
      end
    end

    context '他社のトークルームの場合' do
      let(:auth_header) { headers_other }

      it 'トークルーム一覧が取得できないこと' do
        request
        expect(response).to have_http_status(:forbidden)
        response_json = JSON.parse(response.body)
        expect(response_json['rooms']).to be_nil
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it 'トークルーム一覧が取得できないこと' do
        request
        expect(response).to have_http_status(:unauthorized)
        response_json = JSON.parse(response.body)
        expect(response_json['rooms']).to be_nil
      end
    end
  end

  describe "POST /companies/:company_id/rooms" do
    subject(:request) { post enterprise_v1_company_rooms_path(company.id), headers: auth_header, params: params }
    let!(:company2) { create(:company) }
    let(:params) do
      { room: { account_id: account2.id } }
    end

    context '自社のトークルームの場合' do
      let(:auth_header) { headers_self }

      it 'トークルームが作成できること' do
        expect { request }.to change { Room.count }.by(+1)
        expect(response).to have_http_status(:created)
      end
    end

    context '他社のトークルームの場合' do
      let(:auth_header) { headers_other }

      it 'トークルームが作成できないこと' do
        expect { request }.not_to change { Room.count }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it 'トークルームが作成できないこと' do
        expect { request }.not_to change { Room.count }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
