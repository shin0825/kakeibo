class SpendBudget < ApplicationRecord
  validates :amount, presence:true, length: {maximum: 9}, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :memo, length: {maximum: 50}
  belongs_to :spend_reason, foreign_key: :spend_reason_id
  belongs_to :user

  scope :search_target_date_between, -> (from, to) {
    if from.present? && to.present?
      where(target_date: from..to)
    elsif from.present?
      where('created_at >= ?', from)
    elsif to.present?
      where('created_at <= ?', to)
    end
  }
end
