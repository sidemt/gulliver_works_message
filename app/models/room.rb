# frozen_string_literal: true

class Room < ApplicationRecord
  belongs_to :account
  belongs_to :company
end
