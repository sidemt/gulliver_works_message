# frozen_string_literal: true
module Enterprise
  module V1
    # PrefecturesController
    class PrefecturesController < EnterpriseController
      load_and_authorize_resource

      def index
        render json: @prefectures
      end
    end
  end
end
