# frozen_string_literal: true
module Enterprise
  module V1
    # IndustryCategoriesController
    class IndustryCategoriesController < EnterpriseController
      load_and_authorize_resource

      def index
        render json: @industry_categories
      end
    end
  end
end
