class Message < ApplicationRecord
  belongs_to :room
  belongs_to :account, optional: true
  belongs_to :employee, optional: true

  validates :content, presence: true
end
