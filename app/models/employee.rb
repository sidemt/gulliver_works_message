# frozen_string_literal: true
# Employee
class Employee < ApplicationRecord
  include JWT::Authenticatable

  module EmailVerificationStatus
    UNSPECIFIED = 'unspecified'
    REQUESTED = 'requested'
    VERIFIED = 'verified'
  end

  has_secure_password

  belongs_to :company
  has_many :messages, dependent: :nullify # アカウントが削除されてもトーク履歴が残るようにする

  enum email_verification_status: { unspecified: 0, requested: 1, verified: 2 }

  validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
end
