# frozen_string_literal: true
require 'rails_helper'

RSpec.describe V1::RoomsController, type: :request do
  let!(:account_self) { create(:account) }
  let(:headers_self) { { Authorization: "Bearer #{account_self.jwt}" } }
  let!(:account_other) { create(:account) }
  let(:headers_other) { { Authorization: "Bearer #{account_other.jwt}" } }
  let!(:company) { create(:company) }
  let!(:room) { create(:room, account: account_self, company: company) }

  describe "GET /rooms/:id" do
    subject(:request) { get v1_room_path(room.id), headers: auth_header }

    context '自身のトークルームの場合' do
      let(:auth_header) { headers_self }

      it 'トークルームが取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to eq room.id
      end
    end

    context '他ユーザーのトークルームの場合' do
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

  describe "GET /accounts/:account_id/rooms" do
    subject(:request) { get v1_account_rooms_path(account_self.id), headers: auth_header }

    context '自身のトークルームの場合' do
      let(:auth_header) { headers_self }

      it 'トークルームの一覧が取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['rooms'].size).to eq account_self.rooms.count
      end
    end

    context '他ユーザーのトークルームの場合' do
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

  describe "POST /accounts/:account_id/rooms" do
    subject(:request) { post v1_account_rooms_path(account_self.id), headers: auth_header, params: params }
    let!(:company2) { create(:company) }
    let(:params) do
      { room: { company_id: company2.id } }
    end

    context '自身のトークルームの場合' do
      let(:auth_header) { headers_self }

      it 'トークルームが作成できること' do
        expect { request }.to change { Room.count }.by(+1)
        expect(response).to have_http_status(:created)
      end
    end

    context '他ユーザーのトークルームの場合' do
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
