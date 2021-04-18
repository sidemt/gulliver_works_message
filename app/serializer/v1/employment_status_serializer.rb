# frozen_string_literal: true
module V1
  # EmploymentStatusSerializer
  class EmploymentStatusSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
