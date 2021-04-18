# frozen_string_literal: true
module V1
  # AccountSerializer
  class AccountSerializer < ActiveModel::Serializer
    attributes :id, :email, :email_verification_status
  end
end
