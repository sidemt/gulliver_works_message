# frozen_string_literal: true
# Industry
class Industry < ApplicationRecord
  belongs_to :industry_category

  validates :name, presence: true
  validates :industry_category_id, uniqueness: { scope: :name }
end
