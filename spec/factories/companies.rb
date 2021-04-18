# frozen_string_literal: true
FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "株式会社XXX_#{n}" }
    name_kana { 'カブシキカイシャ' }
    head_office_location { '東京都XX区XX' }
    year_of_establishment { '2020' }
    hp_url { 'https://example.com' }
    phone { '03-1234-5678' }
    capital { 1000 }
    is_listed { false }
    representative { '代表者名' }
    representative_kana { 'ダイヒョウシャメイ' }
    net_sales { '5000' }
    numbers_of_employees { '20' }
    average_age { '28' }
    business_summary { '事業概要' }
    corporate_pr { '企業PR' }
  end
end
