class IncomeReason < ApplicationRecord
  has_many :income

  scope :search_without_transfar, ->() { where.not(id: 999) }
end
