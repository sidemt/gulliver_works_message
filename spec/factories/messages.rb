FactoryBot.define do
  factory :message do
    sequence(:content) { |n| "メッセージ #{n}" }
    association :account
    association :employee
    association :room
  end
end
