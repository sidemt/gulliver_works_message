# frozen_string_literal: true
# OccupationMainCategory
class OccupationMainCategory < ApplicationRecord
  has_many :occupation_sub_categories, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
