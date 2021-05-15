# frozen_string_literal: true

module Enterprise
  module V1
    class MessageSerializer < ActiveModel::Serializer
      attributes :id, :content
      belongs_to :account
      belongs_to :employee
      belongs_to :room
    end
  end
end
