# frozen_string_literal: true
module Auth
  module V1
    # AuthController
    class AuthController < ApplicationController
      skip_before_action :authenticate_account!

      def sign_in
        account = Account.find_by(
          email: resource_params[:email]
        ).try(:authenticate, resource_params[:password])

        account ? render(json: account, serializer: AccountWithTokenSerializer) : head(401)
      end

      def sign_up
        account = Account.create!(resource_params)
        render json: account, status: :created, serializer: AccountWithTokenSerializer
      end

      private

      def resource_params
        params.require(:account).permit(:email, :password)
      end
    end
  end
end
