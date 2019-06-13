# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# # Wallet.create!(name:  "財布A")
# # Wallet.create!(name:  "財布B")
# # Wallet.create!(name:  "USA銀行")
# # Wallet.create!(name:  "瑞鶴銀行")
# # Wallet.create!(name:  "オゾン銀行")

# # User.create!(name:  "S.N",
# #              email: "example@nakascene.jp")
# # User.create!(name:  "HO&GE",
# #              email: "hoge@nakascene.jp")

# # IncomeReason.create!(name:  "給与")
# # IncomeReason.create!(name:  "賞与")
# # IncomeReason.create!(name:  "もらった")
# # IncomeReason.create!(id:999, name:  "振替")

# # Income.create!(
# #   amount:  356789,
# #   wallet_id: 3,
# #   income_reason_id: 1,
# #   user_id: 2,
# #   created_at: Time.new(2019, 6, 15, 9, 00, 00)
# # )

# # Income.create!(
# #   amount:  400000,
# #   wallet_id: 3,
# #   income_reason_id: 2,
# #   user_id: 2,
# #   created_at: Time.new(2019, 6, 30, 9, 00, 00)
# # )
# # Income.create!(
# #   amount:  5000,
# #   wallet_id: 1,
# #   income_reason_id: 3,
# #   user_id: 1,
# #   created_at: Time.new(2019, 6, 1, 9, 00, 00)
# # )
# # Income.create!(
# #   amount:  5000,
# #   wallet_id: 1,
# #   income_reason_id: 3,
# #   user_id: 1,
# #   created_at: Time.new(2019, 6, 2, 9, 00, 00)
# # )
# # Income.create!(
# #   amount:  5000,
# #   wallet_id: 1,
# #   income_reason_id: 3,
# #   user_id: 1,
# #   created_at: Time.new(2019, 6, 3, 9, 00, 00)
# # )
# # Income.create!(
# #   amount:  50000,
# #   wallet_id: 1,
# #   income_reason_id: 999,
# #   user_id: 1,
# #   created_at: Time.new(2019, 6, 15, 15, 00, 00)
# # )

# # SpendReason.create!(name:  "食費")
# # SpendReason.create!(name:  "家賃")
# # SpendReason.create!(name:  "交遊費")
# # SpendReason.create!(id:999, name:  "振替")

# # Spend.create!(
# #   amount:  1000,
# #   wallet_id: 1,
# #   spend_reason_id: 1,
# #   user_id: 1,
# #   created_at: Time.new(2019, 6, 15, 12, 00, 00)
# # )

# # Spend.create!(
# #   amount:  1010,
# #   wallet_id: 1,
# #   spend_reason_id: 1,
# #   user_id: 1,
# #   created_at: Time.new(2019, 6, 16, 12, 00, 00)
# # )

# # Spend.create!(
# #   amount:  1002,
# #   wallet_id: 1,
# #   spend_reason_id: 1,
# #   user_id: 1,
# #   created_at: Time.new(2019, 6, 17, 12, 00, 00)
# # )

# # Spend.create!(
# #   amount:  50000,
# #   wallet_id: 3,
# #   spend_reason_id: 2,
# #   user_id: 2,
# #   created_at: Time.new(2019, 6, 15, 15, 00, 00)
# # )

# # Spend.create!(
# #   amount:  50000,
# #   wallet_id: 3,
# #   spend_reason_id: 999,
# #   user_id: 1,
# #   created_at: Time.new(2019, 6, 15, 15, 00, 00)
# # )

Wallet.create!(name:  "S.N")
Wallet.create!(name:  "共有")
Wallet.create!(name:  "UFJ")
Wallet.create!(name:  "JYUROKU")
Wallet.create!(name:  "AEON")
Wallet.create!(name:  "MIZUHO")

User.create!(name:  "S.N")
User.create!(name:  "R.N")

SpendReason.create!(name:  "食費")
SpendReason.create!(name:  "雑費")
SpendReason.create!(name:  "交遊費")
SpendReason.create!(name:  "宝くじ")
SpendReason.create!(name:  "クレジット")
SpendReason.create!(name:  "定期")
SpendReason.create!(name:  "税金")
SpendReason.create!(name:  "治療費")
SpendReason.create!(name:  "共済")
SpendReason.create!(name:  "スマホ")
SpendReason.create!(name:  "電気")
SpendReason.create!(name:  "ガス")
SpendReason.create!(name:  "水道")
SpendReason.create!(name:  "家賃")
SpendReason.create!(name:  "ネット")
SpendReason.create!(name:  "NHK")
SpendReason.create!(id:999, name:  "振替")

IncomeReason.create!(name:  "給与")
IncomeReason.create!(name:  "賞与")
IncomeReason.create!(name:  "小遣い")
IncomeReason.create!(id:999, name:  "振替")
