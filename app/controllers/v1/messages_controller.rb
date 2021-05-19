# frozen_string_literal: true

module V1
  class MessagesController < ApplicationController
    load_and_authorize_resource :room
    load_and_authorize_resource :message, through: :room, shallow: true

    def index
      render json: @messages
    end

    def show
      render json: @message
    end

    def create
      @message.save!
      render json: @message, status: :created
    end

    private

    def resource_params
      params.require(:message).permit(:account_id,
                                      :content)
    end
  end
end
