# frozen_string_literal: true

module V1
  class RoomsController < ApplicationController
    # account_id の下にネストされるパス
    load_and_authorize_resource :account
    load_and_authorize_resource :room, through: :account, shallow: true

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
      params.require(:room).permit(:company_id)
    end
  end
end


