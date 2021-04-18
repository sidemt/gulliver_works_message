# frozen_string_literal: true
module Enterprise
  module V1
    # IndustrySerializer
    class IndustrySerializer < ActiveModel::Serializer
      attributes :id, :name
    end
  end
end
