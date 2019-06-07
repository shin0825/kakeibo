class Income < ApplicationRecord
  validates :amount, presence:true, length: {maximum: 9}, numericality: { only_integer: true }
  belongs_to :wallet
  belongs_to :income_reason
  belongs_to :user
end
