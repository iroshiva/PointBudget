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

ActiveRecord::Schema.define(version: 2019_09_14_143110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "zip_code"
    t.string "insee_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["insee_code"], name: "index_cities_on_insee_code"
    t.index ["name"], name: "index_cities_on_name"
    t.index ["zip_code"], name: "index_cities_on_zip_code"
  end

  create_table "full_simulations", force: :cascade do |t|
    t.float "total_cost_saved", default: 0.0, null: false
    t.boolean "validated", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "counter", default: 0, null: false
    t.index ["user_id"], name: "index_full_simulations_on_user_id"
  end

  create_table "gas_contracts", force: :cascade do |t|
    t.string "supplier"
    t.string "offer_name"
    t.float "subscription_base_price_month"
    t.float "kwh_price_base"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "low_kw_consumption_per_year"
    t.integer "high_kw_consumption_per_year"
  end

  create_table "gas_simulations", force: :cascade do |t|
    t.float "actual_price_paid"
    t.float "gas_cost_saved"
    t.integer "floor_space"
    t.string "heat_type"
    t.string "water_cooking_type"
    t.integer "residents_number"
    t.integer "gas_use"
    t.bigint "full_simulation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: "Gaz"
    t.index ["full_simulation_id"], name: "index_gas_simulations_on_full_simulation_id"
  end

  create_table "join_table_gas_simulation_contracts", force: :cascade do |t|
    t.bigint "gas_simulation_id"
    t.bigint "gas_contract_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gas_contract_id"], name: "index_join_table_gas_simulation_contracts_on_gas_contract_id"
    t.index ["gas_simulation_id"], name: "index_join_table_gas_simulation_contracts_on_gas_simulation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.boolean "is_admin", default: false
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_users_on_city_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
