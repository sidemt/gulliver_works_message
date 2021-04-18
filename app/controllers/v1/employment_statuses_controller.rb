# frozen_string_literal: true
module V1
  # EmploymentStatusesController
  class EmploymentStatusesController < ApplicationController
    load_and_authorize_resource

    def index
      render json: @employment_statuses
    end
  end
end
