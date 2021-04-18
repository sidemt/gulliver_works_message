# frozen_string_literal: true
module EnterpriseAuth
  module V1
    # EmployeeWithTokenSerializer
    class EmployeeWithTokenSerializer < ActiveModel::Serializer
      attribute :employee do
        ::Enterprise::V1::EmployeeSerializer.new(object).as_json
      end

      attribute :token do
        object.jwt
      end
    end
  end
end
