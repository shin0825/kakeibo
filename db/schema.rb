# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190528155222) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "income_reasons", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incomes", force: :cascade do |t|
    t.integer "amount"
    t.bigint "wallet_id"
    t.bigint "income_reason_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["income_reason_id"], name: "index_incomes_on_income_reason_id"
    t.index ["user_id"], name: "index_incomes_on_user_id"
    t.index ["wallet_id"], name: "index_incomes_on_wallet_id"
  end

  create_table "spend_reasons", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spends", force: :cascade do |t|
    t.integer "amount"
    t.bigint "wallet_id"
    t.bigint "spend_reason_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spend_reason_id"], name: "index_spends_on_spend_reason_id"
    t.index ["user_id"], name: "index_spends_on_user_id"
    t.index ["wallet_id"], name: "index_spends_on_wallet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "incomes", "income_reasons"
  add_foreign_key "incomes", "users"
  add_foreign_key "incomes", "wallets"
  add_foreign_key "spends", "spend_reasons"
  add_foreign_key "spends", "users"
  add_foreign_key "spends", "wallets"
end
