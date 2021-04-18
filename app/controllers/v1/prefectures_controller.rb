# frozen_string_literal: true
module V1
  # PrefecturesController
  class PrefecturesController < ApplicationController
    load_and_authorize_resource

    def index
      render json: @prefectures
    end
  end
end
