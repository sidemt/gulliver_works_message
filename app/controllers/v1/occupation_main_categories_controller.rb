# frozen_string_literal: true
module V1
  # OccupationMainCategoriesController
  class OccupationMainCategoriesController < ApplicationController
    load_and_authorize_resource

    def index
      render json: @occupation_main_categories, include: { occupation_sub_categories: [:occupations] }
    end
  end
end
