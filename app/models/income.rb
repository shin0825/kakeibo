class Income < ApplicationRecord
  belongs_to :wallet
  belongs_to :income_reason
  belongs_to :user
end
