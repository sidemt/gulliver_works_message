# frozen_string_literal: true
# Prefecture
class Prefecture < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
