class Spend < ApplicationRecord
  VALID_AMOUNT_REGEX = /\A[0-9]+\z/
  validates :amount, presence:true, length: {maximum: 9}, format: {with: VALID_AMOUNT_REGEX }
  belongs_to :wallet
  belongs_to :spend_reason
  belongs_to :user
end
