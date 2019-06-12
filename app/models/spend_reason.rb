class SpendReason < ApplicationRecord
  has_many :spend
  has_many :spend_budget

  scope :search_without_transfar, ->() { where.not(id: 999) }
end
