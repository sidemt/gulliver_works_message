# frozen_string_literal: true
module V1
  # AccountsController
  class AccountsController < ApplicationController
    load_and_authorize_resource

    def index
      render json: @accounts
    end

    def show
      render json: @account
    end

    def destroy
      @account.destroy!
      head 204
    end
  end
end
