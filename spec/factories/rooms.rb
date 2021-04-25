FactoryBot.define do
  factory :room do
    association :account
    association :company
  end
end
