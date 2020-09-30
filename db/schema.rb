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

ActiveRecord::Schema.define(version: 2020_09_29_222356) do

  create_table "customers", force: :cascade do |t|
    t.integer "order_id"
    t.string "externalCode"
    t.string "name"
    t.string "email"
    t.string "contact"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: :cascade do |t|
    t.integer "order_id"
    t.string "externalCode"
    t.string "name"
    t.decimal "price", precision: 9, scale: 2
    t.integer "quantity"
    t.decimal "total", precision: 9, scale: 2
    t.integer "subItem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.string "externalCode"
    t.string "storeId"
    t.string "subTotal"
    t.string "deliveryFee"
    t.string "total"
    t.datetime "dtOrderCreate", precision: 3
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "district"
    t.string "street"
    t.string "number"
    t.string "complement"
    t.string "postalCode"
    t.decimal "latitude", precision: 9, scale: 6
    t.decimal "longitude", precision: 9, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "order_id"
    t.string "payment_type"
    t.string "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
