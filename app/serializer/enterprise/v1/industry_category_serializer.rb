# frozen_string_literal: true
module Enterprise
  module V1
    # IndustryCategorySerializer
    class IndustryCategorySerializer < ActiveModel::Serializer
      attributes :id, :name

      has_many :industries
    end
  end
end
