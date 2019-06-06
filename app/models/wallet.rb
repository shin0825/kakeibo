class Wallet < ApplicationRecord
  has_many :income
  has_many :spend
end
