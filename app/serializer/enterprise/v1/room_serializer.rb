# frozen_string_literal: true

module Enterprise
  module V1
    class RoomSerializer < ActiveModel::Serializer
      attributes :id
      belongs_to :account
      belongs_to :company
    end
  end
end
