# frozen_string_literal: true
# Occupation
class Occupation < ApplicationRecord
  belongs_to :occupation_sub_category

  validates :name, presence: true, uniqueness: true
end
