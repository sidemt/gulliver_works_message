# frozen_string_literal: true
FactoryBot.define do
  factory :employment_status do
    sequence(:name) { |n| "雇用形態_#{n}" }
  end
end
