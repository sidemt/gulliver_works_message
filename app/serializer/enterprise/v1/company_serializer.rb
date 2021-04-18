# frozen_string_literal: true
module Enterprise
  module V1
    # CompanySerializer
    class CompanySerializer < ActiveModel::Serializer
      attributes :id,
                 :name,
                 :name_kana,
                 :head_office_location,
                 :year_of_establishment,
                 :hp_url,
                 :phone,
                 :capital,
                 :is_listed,
                 :representative,
                 :representative_kana,
                 :net_sales,
                 :numbers_of_employees,
                 :average_age,
                 :business_summary,
                 :corporate_pr
    end
  end
end
