# frozen_string_literal: true
FactoryBot.define do
  factory :occupation do
    sequence(:name) { |n| "職種（小項目）_#{n}" }
    association :occupation_sub_category
  end
end
