require 'rails_helper'

RSpec.describe Enterprise::V1::MessagesController, type: :request do

  # Company の準備
  let!(:company) { create(:company) }
  let!(:company2) { create(:company) }
  # Employee の準備
  let!(:employee) { create(:employee, company: company) }
  let(:headers_self) { { Authorization: "Bearer #{employee.jwt}" } }
  let!(:employee_same_company) { create(:employee, company: company) }
  let(:headers_same_company) { { Authorization: "Bearer #{employee_same_company.jwt}" } }
  let!(:employee_other_company) { create(:employee, company: company2) }
  let(:headers_other) { { Authorization: "Bearer #{employee_other_company.jwt}" } }
  # Account の準備
  let!(:account) { create(:account) }
  # Room の準備
  let!(:room) { create(:room, account: account, company: company) }
  # Message の準備
  let!(:messages) { create_list(:message, 5, employee: employee, room: room) }
  let!(:messages_from_account) { create_list(:message, 5, account: account, room: room) }

  describe "GET /messages/:id" do
    subject(:request) { get enterprise_v1_message_path(message_id), headers: auth_header }

    context '自社のトークルーム内のメッセージの場合' do
      # itを共通化
      shared_examples_for 'メッセージが取得できること' do
        it do
          request
          expect(response).to have_http_status(:ok)
          response_json = JSON.parse(response.body)
          expect(response_json['id']).to eq message_id
        end
      end

      context '自身のメッセージの場合' do
        let(:auth_header) { headers_self }
        let(:message_id) { messages.first.id }
        it_behaves_like 'メッセージが取得できること'
      end

      context '他ユーザー(Account)からのメッセージの場合' do
        let(:auth_header) { headers_self }
        let(:message_id) { messages_from_account.first.id }
        it_behaves_like 'メッセージが取得できること'
      end

      context '自社の他従業員からのメッセージの場合' do
        let(:auth_header) { headers_same_company }
        let(:message_id) { messages.first.id }
        it_behaves_like 'メッセージが取得できること'
      end
    end

    context '他社のトークルーム内のメッセージの場合' do
      let(:auth_header) { headers_other }
      let(:message_id) { messages.first.id }

      it 'メッセージが取得できないこと' do
        request
        expect(response).to have_http_status(:forbidden)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to be_nil
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }
      let(:message_id) { messages.first.id }

      it 'メッセージが取得できないこと' do
        request
        expect(response).to have_http_status(:unauthorized)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to be_nil
      end
    end
  end

  describe "GET /rooms/:room_id/messages" do
    subject(:request) { get enterprise_v1_room_messages_path(room.id), headers: auth_header }

    context '自社のトークルームの場合' do
      let(:auth_header) { headers_self }

      it 'メッセージ一覧が取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['messages'].size).to eq room.messages.count
      end
    end

    context '他社のトークルームの場合' do
      let(:auth_header) { headers_other }

      it 'メッセージ一覧が取得できないこと' do
        request
        expect(response).to have_http_status(:forbidden)
        response_json = JSON.parse(response.body)
        expect(response_json['messages']).to be_nil
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it 'メッセージ一覧が取得できないこと' do
        request
        expect(response).to have_http_status(:unauthorized)
        response_json = JSON.parse(response.body)
        expect(response_json['messages']).to be_nil
      end
    end
  end

  describe "POST /rooms/:room_id/messages" do
    subject(:request) { post enterprise_v1_room_messages_path(room.id), headers: auth_header, params: params }
    let(:params) do
      { message: attributes_for(:message).merge(employee_id: employee.id) }
    end

    context '自社のトークルームの場合' do
      let(:auth_header) { headers_self }

      it 'メッセージが作成できること' do
        expect { request }.to change { Message.count }.by(+1)
        expect(response).to have_http_status(:created)
      end
    end

    context '他社のトークルームの場合' do
      let(:auth_header) { headers_other }

      it 'メッセージが作成できないこと' do
        expect { request }.not_to change { Message.count }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it 'メッセージが作成できないこと' do
        expect { request }.not_to change { Message.count }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
