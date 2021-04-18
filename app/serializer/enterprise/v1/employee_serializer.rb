# frozen_string_literal: true
module Enterprise
  module V1
    # EmployeeSerializer
    class EmployeeSerializer < ActiveModel::Serializer
      attributes :id, :email, :email_verification_status, :company_id
    end
  end
end
