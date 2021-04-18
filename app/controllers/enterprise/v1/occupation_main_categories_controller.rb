# frozen_string_literal: true
module Enterprise
  module V1
    # OccupationMainCategoriesController
    class OccupationMainCategoriesController < EnterpriseController
      load_and_authorize_resource

      def index
        render json: @occupation_main_categories, include: { occupation_sub_categories: [:occupations] }
      end
    end
  end
end
