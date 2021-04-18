# frozen_string_literal: true
# EmploymentStatus
class EmploymentStatus < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
