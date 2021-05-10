# frozen_string_literal: true
# Company
class Company < ApplicationRecord
  has_many :employees, dependent: :destroy
  has_many :rooms, dependent: :nullify

  validates :name, uniqueness: true, presence: true
  validates :name_kana,
            :head_office_location,
            :year_of_establishment,
            :capital,
            :representative,
            :representative_kana,
            :business_summary, presence: true
  validates :is_listed, inclusion: [true, false]
end
