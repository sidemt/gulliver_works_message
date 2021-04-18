# frozen_string_literal: true
FactoryBot.define do
  factory :occupation_main_category do
    sequence(:name) { |n| "職種（大項目）_#{n}" }
  end
end
