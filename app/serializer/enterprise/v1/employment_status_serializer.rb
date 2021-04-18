# frozen_string_literal: true
module Enterprise
  module V1
    # EmploymentStatusSerializer
    class EmploymentStatusSerializer < ActiveModel::Serializer
      attributes :id, :name
    end
  end
end
