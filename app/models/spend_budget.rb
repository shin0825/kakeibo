class SpendBudget < ApplicationRecord
  validates :amount, presence:true, length: {maximum: 9}, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :memo, length: {maximum: 50}
  belongs_to :spend_reason, foreign_key: :spend_reason_id
  belongs_to :user
end
