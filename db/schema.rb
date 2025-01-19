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

ActiveRecord::Schema[7.2].define(version: 2025_01_17_094737) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "brand_receipts", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.integer "hardnessShA"
    t.integer "hardnessShD"
    t.float "density"
    t.integer "receipt_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_receipts_on_brand_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "intended_use"
    t.bigint "creator_id", null: false
    t.float "calculated_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_brands_on_creator_id"
  end

  create_table "coil_registers", force: :cascade do |t|
    t.string "name"
    t.integer "address"
    t.string "description"
    t.boolean "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "creators", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "position"
    t.string "order_description"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_creators_on_user_id", unique: true
  end

  create_table "data_flows", force: :cascade do |t|
    t.float "torque"
    t.integer "speed"
    t.integer "mold_temp"
    t.integer "material_temp"
    t.integer "testing_time"
    t.integer "voltage"
    t.float "current"
    t.float "frequency"
    t.float "power"
    t.float "energy"
    t.integer "alarm"
    t.bigint "test_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_data_flows_on_test_id"
  end

  create_table "handling_registers", force: :cascade do |t|
    t.string "name"
    t.integer "address"
    t.string "description"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.datetime "date"
    t.string "name"
    t.string "description"
    t.bigint "supplier_id", null: false
    t.float "price"
    t.string "note"
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "density"
    t.index ["supplier_id"], name: "index_materials_on_supplier_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.bigint "brand_receipt_id", null: false
    t.bigint "material_id", null: false
    t.float "amount_g"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_name"
    t.float "sum_s"
    t.float "volume_cc"
    t.string "note"
    t.index ["brand_receipt_id"], name: "index_receipts_on_brand_receipt_id"
    t.index ["material_id"], name: "index_receipts_on_material_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "mobile"
    t.string "email"
    t.string "website"
    t.string "contact_person"
    t.string "note"
    t.string "product_list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.string "address"
    t.string "phone"
    t.string "product_ids"
    t.bigint "creator_id"
    t.decimal "reliability"
    t.string "country"
    t.boolean "producer"
    t.string "image"
  end

  create_table "tests", force: :cascade do |t|
    t.bigint "brand_receipt_id", null: false
    t.bigint "creator_id", null: false
    t.integer "total_time"
    t.float "temperature"
    t.float "torque1"
    t.integer "time1"
    t.float "torque2"
    t.integer "time2"
    t.float "torque3"
    t.integer "time3"
    t.float "torque4"
    t.integer "time4"
    t.integer "melting_time"
    t.integer "start_melting"
    t.integer "end_melting"
    t.float "total_energy"
    t.float "te_persec"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_receipt_id"], name: "index_tests_on_brand_receipt_id"
    t.index ["creator_id"], name: "index_tests_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "brand_receipts", "brands"
  add_foreign_key "brands", "creators"
  add_foreign_key "creators", "users"
  add_foreign_key "data_flows", "tests"
  add_foreign_key "materials", "suppliers"
  add_foreign_key "receipts", "brand_receipts"
  add_foreign_key "receipts", "materials"
  add_foreign_key "tests", "brand_receipts"
  add_foreign_key "tests", "creators"
end
