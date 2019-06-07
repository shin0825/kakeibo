class Income < ApplicationRecord
  validates :amount, presence:true, length: {maximum: 9}, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  belongs_to :wallet
  belongs_to :income_reason
  belongs_to :user
end
