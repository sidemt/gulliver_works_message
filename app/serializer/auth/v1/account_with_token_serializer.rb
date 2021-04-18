# frozen_string_literal: true
module Auth
  module V1
    # AccountWithTokenSerializer
    class AccountWithTokenSerializer < ActiveModel::Serializer
      attribute :account do
        ::V1::AccountSerializer.new(object).as_json
      end

      attribute :token do
        object.jwt
      end
    end
  end
end
