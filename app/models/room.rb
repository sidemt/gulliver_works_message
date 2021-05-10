# frozen_string_literal: true

class Room < ApplicationRecord
  belongs_to :account
  belongs_to :company

  validates :company, uniqueness: { scope: :account, message: '同じユーザー・企業のトークルームが既に存在します。' }
end
