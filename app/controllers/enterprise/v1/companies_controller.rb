# frozen_string_literal: true
module Enterprise
  module V1
    # CompaniesController
    class CompaniesController < EnterpriseController
      skip_before_action :authenticate_employee!, only: :create

      load_and_authorize_resource

      def index
        render json: @companies
      end

      def show
        render json: @company
      end

      def create
        @company.save!
        render json: @company, status: :created
      end

      def update
        @company.update!(resource_params)
        render json: @company
      end

      def destroy
        @company.destroy!
        head 204
      end

      private

      def resource_params
        params.require(:company).permit(
          :name,
          :name_kana,
          :head_office_location,
          :year_of_establishment,
          :hp_url,
          :phone,
          :capital,
          :is_listed,
          :representative,
          :representative_kana,
          :net_sales,
          :numbers_of_employees,
          :average_age,
          :business_summary,
          :corporate_pr
        )
      end
    end
  end
end
