# frozen_string_literal: true
FactoryBot.define do
  factory :employee do
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { 'password' }
    association :company
  end
end
