# frozen_string_literal: true
module V1
  # OccupationSubCategorySerializer
  class OccupationSubCategorySerializer < ActiveModel::Serializer
    attributes :id, :name

    has_many :occupations
  end
end
