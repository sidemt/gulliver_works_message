# frozen_string_literal: true
module Enterprise
  module V1
    # OccupationMainCategorySerializer
    class OccupationMainCategorySerializer < ActiveModel::Serializer
      attributes :id, :name

      has_many :occupation_sub_categories
    end
  end
end
