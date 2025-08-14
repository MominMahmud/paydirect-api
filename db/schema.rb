# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_14_181548) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "subscriptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "owner_id", null: false
    t.uuid "tenant_id", null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.string "currency", default: "PKR", null: false
    t.integer "frequency", default: 2, null: false
    t.date "next_due_date", null: false
    t.integer "retry_attempts", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_subscriptions_on_owner_id"
    t.index ["tenant_id"], name: "index_subscriptions_on_tenant_id"
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "from_wallet_id", null: false
    t.uuid "to_wallet_id", null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.string "currency", default: "PKR"
    t.integer "payment_type", default: 0
    t.integer "status", default: 0
    t.text "failure_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_wallet_id"], name: "index_transactions_on_from_wallet_id"
    t.index ["to_wallet_id"], name: "index_transactions_on_to_wallet_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "phone"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.decimal "balance"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "subscriptions", "users", column: "owner_id"
  add_foreign_key "subscriptions", "users", column: "tenant_id"
  add_foreign_key "transactions", "wallets", column: "from_wallet_id"
  add_foreign_key "transactions", "wallets", column: "to_wallet_id"
  add_foreign_key "wallets", "users"
end
