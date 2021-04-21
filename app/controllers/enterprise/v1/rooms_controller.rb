# frozen_string_literal: true

module Enterprise
  module V1
    class RoomsController < EnterpriseController
      # company_id の下にネストされるパス
      load_and_authorize_resource :company, except: :show
      load_and_authorize_resource :room, through: :company, except: :show
      # Room の id を指定してアクセスするパス
      load_and_authorize_resource only: :show

      def index
        render json: @rooms
      end

      def show
        render json: @room
      end

      def create
        @room.save!
        render json: @room, status: :created
      end

      private

      def resource_params
        params.require(:room).permit(:account_id)
      end
    end
  end
end
