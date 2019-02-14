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

ActiveRecord::Schema.define(version: 2019_02_13_200038) do

  create_table "entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "entry_on", null: false
    t.boolean "tracked_food", default: false
    t.boolean "stayed_under_calorie_goal", default: false
    t.boolean "closed_move_ring", default: false
    t.boolean "closed_exercise_ring", default: false
    t.boolean "closed_stand_ring", default: false
    t.boolean "went_to_gym", default: false
    t.boolean "met_sleep_goal", default: false
    t.integer "steps"
    t.integer "total_calories_consumed"
    t.integer "total_calories_burned"
    t.integer "active_calories_burned"
    t.decimal "weight", precision: 5, scale: 2
    t.decimal "calf_measurement", precision: 5, scale: 2
    t.decimal "thigh_measurement", precision: 5, scale: 2
    t.decimal "waist_measurement", precision: 5, scale: 2
    t.decimal "stomach_measurement", precision: 5, scale: 2
    t.decimal "shoulder_measurement", precision: 5, scale: 2
    t.decimal "arm_measurement", precision: 5, scale: 2
    t.decimal "neck_measurement", precision: 5, scale: 2
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entry_on"], name: "index_entries_on_entry_on"
  end

  create_table "versions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "item_type", limit: 191, null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 4294967295
    t.datetime "created_at"
    t.text "object_changes", limit: 4294967295
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
