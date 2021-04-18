# frozen_string_literal: true
module V1
  # OccupationSerializer
  class OccupationSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
