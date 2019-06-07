class Spend < ApplicationRecord
  validates :amount, presence:true, length: {maximum: 9}, numericality: { only_integer: true }
  belongs_to :wallet
  belongs_to :spend_reason
  belongs_to :user
end
