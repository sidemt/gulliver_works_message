# frozen_string_literal: true
# IndustryCategory
class IndustryCategory < ApplicationRecord
  has_many :industries, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
