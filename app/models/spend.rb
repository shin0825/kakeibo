class Spend < ApplicationRecord
  belongs_to :wallet
  belongs_to :spend_reason
  belongs_to :user
end
