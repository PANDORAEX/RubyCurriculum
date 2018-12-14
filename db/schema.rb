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

ActiveRecord::Schema.define(version: 2018_08_14_053919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "languages", primary_key: "language_code", id: :string, limit: 2, force: :cascade do |t|
    t.string "language_name", limit: 20, null: false
  end

  create_table "project_sequences", primary_key: "name", id: :string, force: :cascade do |t|
    t.integer "number"
  end

  create_table "projects", primary_key: "project_id", id: :decimal, precision: 4, force: :cascade do |t|
    t.date "start_date", null: false
    t.string "project_no", limit: 15, null: false
    t.string "project_name", limit: 30, null: false
    t.string "protype_code", limit: 2, null: false
    t.string "language_code", limit: 2, null: false
    t.string "summary", limit: 255, null: false
    t.string "status_code", limit: 1, null: false
    t.string "customer", limit: 20
    t.string "charge", limit: 20
    t.string "reviewer", limit: 20
    t.date "release_date"
    t.string "remarks", limit: 255
  end

  create_table "projecttypes", primary_key: "protype_code", id: :string, limit: 2, force: :cascade do |t|
    t.string "protype_name", limit: 20, null: false
  end

  create_table "statuses", primary_key: "status_code", id: :string, limit: 2, force: :cascade do |t|
    t.string "status_name", limit: 20, null: false
  end

  create_table "users", primary_key: "userid", id: :string, limit: 8, force: :cascade do |t|
    t.string "password", limit: 50, null: false
  end

  add_foreign_key "projects", "languages", column: "language_code", primary_key: "language_code", name: "fk_language_code", on_delete: :restrict
  add_foreign_key "projects", "projecttypes", column: "protype_code", primary_key: "protype_code", name: "fk_protype_code", on_delete: :restrict
  add_foreign_key "projects", "statuses", column: "status_code", primary_key: "status_code", name: "fk_status_code", on_delete: :restrict
end
