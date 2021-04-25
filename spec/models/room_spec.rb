require 'rails_helper'

RSpec.describe Room, type: :model do
  let!(:account) { create(:account) }
  let!(:company) { create(:company) }
  let!(:account2) { create(:account) }
  let!(:company2) { create(:company) }
  let!(:room) { create(:room, account: account, company: company) }

  describe 'バリデーション' do
    context '同じユーザー・会社組み合わせのトークルームがすでに存在する場合' do
      let(:new_room) { build(:room, account: account, company: company) }
      it '無効であること' do
        expect(new_room).not_to be_valid
      end
    end

    context 'ユーザーが異なる場合' do
      let(:new_room) { build(:room, account: account2, company: company) }
      it '有効であること' do
        expect(new_room).to be_valid
      end
    end

    context '会社が異なる場合' do
      let(:new_room) { build(:room, account: account, company: company2) }
      it '有効であること' do
        expect(new_room).to be_valid
      end
    end
  end
end
