# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Wallet.create!(name:  "Example Wallet")

99.times do |n|
  name  = Faker::Name.name
  Wallet.create!(name:  name)
end

User.create!(name:  "Example User",
             email: "example@nakascene.jp")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@nakascene.jp"
  User.create!(name:  name,
              email: email)
end

IncomeReason.create!(name:  "給与")
IncomeReason.create!(name:  "振替先")

Income.create!(
  amount:  230000,
  wallet_id: 1,
  income_reason_id: 1,
  user_id: 1
)
Income.create!(
  amount:  5000,
  wallet_id: 1,
  income_reason_id: 1,
  user_id: 1
)
Income.create!(
  amount:  4000,
  wallet_id: 1,
  income_reason_id: 1,
  user_id: 1
)

SpendReason.create!(name:  "食費")
SpendReason.create!(name:  "その他")

Spend.create!(
  amount:  45000,
  wallet_id: 1,
  spend_reason_id: 1,
  user_id: 1
)
Spend.create!(
  amount:  123,
  wallet_id: 1,
  spend_reason_id: 1,
  user_id: 1
)
Spend.create!(
  amount:  456,
  wallet_id: 1,
  spend_reason_id: 1,
  user_id: 1
)
