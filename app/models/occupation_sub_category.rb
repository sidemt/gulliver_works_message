# frozen_string_literal: true
# OccupationSubCategory
class OccupationSubCategory < ApplicationRecord
  has_many :occupations, dependent: :destroy
  belongs_to :occupation_main_category

  validates :name, presence: true, uniqueness: true
end
