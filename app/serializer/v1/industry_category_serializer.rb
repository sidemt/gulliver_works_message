# frozen_string_literal: true
module V1
  # IndustryCategorySerializer
  class IndustryCategorySerializer < ActiveModel::Serializer
    attributes :id, :name

    has_many :industries
  end
end
