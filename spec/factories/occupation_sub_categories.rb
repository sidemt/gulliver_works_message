# frozen_string_literal: true
FactoryBot.define do
  factory :occupation_sub_category do
    sequence(:name) { |n| "職種（中項目）_#{n}" }
    association :occupation_main_category
  end
end
