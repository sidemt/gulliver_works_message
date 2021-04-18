# frozen_string_literal: true
module EnterpriseAuth
  module V1
    # AuthController
    class AuthController < EnterpriseController
      skip_before_action :authenticate_employee!

      def sign_in
        employee = Employee.find_by(
          email: resource_params[:email]
        ).try(:authenticate, resource_params[:password])

        employee ? render(json: employee, serializer: EmployeeWithTokenSerializer) : head(401)
      end

      def sign_up
        employee = Employee.create!(resource_params)
        render json: employee, status: :created, serializer: EmployeeWithTokenSerializer
      end

      private

      def resource_params
        params.require(:employee).permit(:email, :password, :company_id)
      end
    end
  end
end
