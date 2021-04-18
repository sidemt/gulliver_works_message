# frozen_string_literal: true
FactoryBot.define do
  factory :industry_category do
    sequence(:name) { |n| "業種カテゴリー_#{n}" }
  end
end
