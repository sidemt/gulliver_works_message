# frozen_string_literal: true
module V1
  # IndustryCategoriesController
  class IndustryCategoriesController < ApplicationController
    load_and_authorize_resource

    def index
      render json: @industry_categories
    end
  end
end
