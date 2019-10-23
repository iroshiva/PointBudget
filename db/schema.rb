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

ActiveRecord::Schema.define(version: 2019_10_21_120528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bank_contracts", force: :cascade do |t|
    t.string "supplier", default: ""
    t.string "group_name", default: ""
    t.float "accounting_fees", default: 0.0
    t.float "inactive_accounting_fees", default: 0.0
    t.boolean "cheque", default: true
    t.float "price_cheque", default: 0.0
    t.float "price_order_cheque", default: 0.0
    t.float "insurance_payment", default: 0.0
    t.float "sms_alert", default: 0.0
    t.float "international_withdraw", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bank_simulations", force: :cascade do |t|
    t.float "bank_cost_saved", default: 0.0
    t.float "accounting_fees", default: 0.0
    t.float "inactive_accounting_fees", default: 0.0
    t.float "price_cheque", default: 0.0
    t.float "insurance_payment", default: 0.0
    t.float "sms_alert", default: 0.0
    t.float "international_withdraw", default: 0.0
    t.string "name", default: "Bank"
    t.bigint "full_simulation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["full_simulation_id"], name: "index_bank_simulations_on_full_simulation_id"
  end

  create_table "box_contracts", force: :cascade do |t|
    t.string "supplier", default: ""
    t.string "offer_name", default: ""
    t.float "price_month", default: 0.0
    t.integer "commitment", default: 0
    t.float "price_after", default: 0.0
    t.string "internet_type"
    t.integer "downstream", default: 0
    t.integer "upstream", default: 0
    t.string "tv_channel", default: ""
    t.boolean "tv"
    t.boolean "call_fix_fr"
    t.boolean "call_mobile_fr"
    t.boolean "call_foreign"
    t.float "opening_fee", default: 0.0
    t.float "termination_fee", default: 0.0
    t.float "taken_termination", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "box_simulations", force: :cascade do |t|
    t.float "actual_price_paid", default: 0.0
    t.float "box_cost_saved", default: 0.0
    t.boolean "tv", default: true
    t.boolean "call_fix_fr", default: true
    t.boolean "call_mob_fr", default: true
    t.string "name", default: "Box Internet"
    t.bigint "full_simulation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["full_simulation_id"], name: "index_box_simulations_on_full_simulation_id"
  end

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

  create_table "ele_contracts", force: :cascade do |t|
    t.string "supplier"
    t.string "offer_name"
    t.integer "kVA_power"
    t.float "subscription_base_price_month"
    t.float "kwh_price_base"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ele_simulations", force: :cascade do |t|
    t.float "actual_price_paid"
    t.float "ele_cost_saved"
    t.integer "ele_use"
    t.bigint "full_simulation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: "Electricité"
    t.index ["full_simulation_id"], name: "index_ele_simulations_on_full_simulation_id"
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
    t.string "isolation_type"
    t.index ["full_simulation_id"], name: "index_gas_simulations_on_full_simulation_id"
  end

  create_table "join_table_bank_contracts", force: :cascade do |t|
    t.float "savings", default: 0.0
    t.bigint "bank_simulation_id"
    t.bigint "bank_contract_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_contract_id"], name: "index_join_table_bank_contracts_on_bank_contract_id"
    t.index ["bank_simulation_id"], name: "index_join_table_bank_contracts_on_bank_simulation_id"
  end

  create_table "join_table_box_contracts", force: :cascade do |t|
    t.float "savings"
    t.bigint "box_contract_id"
    t.bigint "box_simulation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["box_contract_id"], name: "index_join_table_box_contracts_on_box_contract_id"
    t.index ["box_simulation_id"], name: "index_join_table_box_contracts_on_box_simulation_id"
  end

  create_table "join_table_ele_simulation_contracts", force: :cascade do |t|
    t.float "savings", default: 0.0
    t.float "float", default: 0.0
    t.bigint "ele_simulation_id"
    t.bigint "ele_contract_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ele_contract_id"], name: "index_join_table_ele_simulation_contracts_on_ele_contract_id"
    t.index ["ele_simulation_id"], name: "index_join_table_ele_simulation_contracts_on_ele_simulation_id"
  end

  create_table "join_table_gas_simulation_contracts", force: :cascade do |t|
    t.bigint "gas_simulation_id"
    t.bigint "gas_contract_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "savings", default: 0.0
    t.index ["gas_contract_id"], name: "index_join_table_gas_simulation_contracts_on_gas_contract_id"
    t.index ["gas_simulation_id"], name: "index_join_table_gas_simulation_contracts_on_gas_simulation_id"
  end

  create_table "join_table_mobil_contracts", force: :cascade do |t|
    t.float "savings", default: 0.0
    t.bigint "mobil_simulation_id"
    t.bigint "mobil_contract_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mobil_contract_id"], name: "index_join_table_mobil_contracts_on_mobil_contract_id"
    t.index ["mobil_simulation_id"], name: "index_join_table_mobil_contracts_on_mobil_simulation_id"
  end

  create_table "mobil_contracts", force: :cascade do |t|
    t.string "supplier"
    t.string "offer_name"
    t.integer "line_service_price", default: 0
    t.integer "sim_card_price", default: 0
    t.boolean "engagement", default: false
    t.boolean "add_phone", default: false
    t.float "bundle_price", default: 0.0
    t.float "bundle_gbyte", default: 0.0
    t.boolean "calls_france", default: false
    t.boolean "calls_europe", default: false
    t.float "gbyte_europe", default: 0.0
    t.boolean "calls_international", default: false
    t.boolean "net_international", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mobil_simulations", force: :cascade do |t|
    t.string "name", default: "Mobile"
    t.float "actual_price_paid", default: 0.0
    t.float "mobil_cost_saved", default: 0.0
    t.boolean "engagement", default: false
    t.boolean "calls_europe", default: false
    t.boolean "calls_international", default: false
    t.boolean "net_international", default: false
    t.float "bundle_go", default: 0.0
    t.bigint "full_simulation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["full_simulation_id"], name: "index_mobil_simulations_on_full_simulation_id"
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
    t.string "provider"
    t.string "uid"
    t.index ["city_id"], name: "index_users_on_city_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
