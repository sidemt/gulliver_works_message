# frozen_string_literal: true
module Enterprise
  module V1
    # EmploymentStatusesController
    class EmploymentStatusesController < EnterpriseController
      load_and_authorize_resource

      def index
        render json: @employment_statuses
      end
    end
  end
end
