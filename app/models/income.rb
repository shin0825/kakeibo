class Income < ApplicationRecord
  validates :amount, presence:true, length: {maximum: 9}, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  belongs_to :wallet
  belongs_to :income_reason, foreign_key: :income_reason_id
  belongs_to :user

  scope :search_without_transfar, ->() { where.not(income_reason_id: 999) }
end
