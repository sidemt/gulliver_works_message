# frozen_string_literal: true
FactoryBot.define do
  factory :industry do
    sequence(:name) { |n| "業種_#{n}" }
    association :industry_category
  end
end
