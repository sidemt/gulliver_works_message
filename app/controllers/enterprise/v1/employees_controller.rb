# frozen_string_literal: true
module Enterprise
  module V1
    # EmployeesController
    class EmployeesController < EnterpriseController
      load_and_authorize_resource

      def show
        render json: @employee
      end

      def destroy
        @employee.destroy!
        head 204
      end
    end
  end
end
