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

ActiveRecord::Schema[8.0].define(version: 2026_03_05_131500) do
  create_table "activities", force: :cascade do |t|
    t.integer "lead_id", null: false
    t.integer "user_id"
    t.string "kind", null: false
    t.datetime "occurred_at", null: false
    t.text "notes"
    t.integer "duration_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind"], name: "index_activities_on_kind"
    t.index ["lead_id"], name: "index_activities_on_lead_id"
    t.index ["occurred_at"], name: "index_activities_on_occurred_at"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "follow_ups", force: :cascade do |t|
    t.integer "lead_id", null: false
    t.integer "user_id"
    t.date "due_on", null: false
    t.string "status", default: "pending", null: false
    t.datetime "completed_at"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["due_on"], name: "index_follow_ups_on_due_on"
    t.index ["lead_id"], name: "index_follow_ups_on_lead_id"
    t.index ["status"], name: "index_follow_ups_on_status"
    t.index ["user_id"], name: "index_follow_ups_on_user_id"
  end

  create_table "gate_entries", force: :cascade do |t|
    t.string "vin", null: false
    t.string "make", null: false
    t.string "model", null: false
    t.integer "year", null: false
    t.string "color"
    t.integer "mileage"
    t.date "arrived_at", null: false
    t.string "stock_number"
    t.string "status", default: "received", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arrived_at"], name: "index_gate_entries_on_arrived_at"
    t.index ["status"], name: "index_gate_entries_on_status"
    t.index ["vin"], name: "index_gate_entries_on_vin", unique: true
  end

  create_table "lead_stage_transitions", force: :cascade do |t|
    t.integer "lead_id", null: false
    t.integer "from_stage_id"
    t.integer "to_stage_id", null: false
    t.integer "user_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_lead_stage_transitions_on_created_at"
    t.index ["from_stage_id"], name: "index_lead_stage_transitions_on_from_stage_id"
    t.index ["lead_id"], name: "index_lead_stage_transitions_on_lead_id"
    t.index ["to_stage_id"], name: "index_lead_stage_transitions_on_to_stage_id"
    t.index ["user_id"], name: "index_lead_stage_transitions_on_user_id"
  end

  create_table "lead_stages", force: :cascade do |t|
    t.string "name", null: false
    t.integer "position", default: 0, null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_lead_stages_on_name", unique: true
    t.index ["position"], name: "index_lead_stages_on_position"
  end

  create_table "leads", force: :cascade do |t|
    t.string "lead_number"
    t.string "source"
    t.string "sub_source"
    t.string "campaign_name"
    t.integer "current_stage_id", null: false
    t.integer "assigned_cre_id"
    t.integer "assigned_sales_exec_id"
    t.string "customer_name", null: false
    t.string "mobile_number", null: false
    t.string "alternate_number"
    t.string "email"
    t.string "city"
    t.text "address"
    t.string "interested_model"
    t.string "variant"
    t.string "fuel_type"
    t.string "color_preference"
    t.string "budget_range"
    t.integer "lead_score"
    t.string "temperature"
    t.date "expected_purchase_on"
    t.datetime "last_call_at"
    t.datetime "last_whatsapp_at"
    t.date "next_follow_up_on"
    t.integer "follow_up_count", default: 0, null: false
    t.text "notes"
    t.decimal "booking_amount", precision: 12, scale: 2
    t.date "booking_date"
    t.string "payment_mode"
    t.date "delivery_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["assigned_cre_id"], name: "index_leads_on_assigned_cre_id"
    t.index ["assigned_sales_exec_id"], name: "index_leads_on_assigned_sales_exec_id"
    t.index ["current_stage_id"], name: "index_leads_on_current_stage_id"
    t.index ["lead_number"], name: "index_leads_on_lead_number"
    t.index ["mobile_number"], name: "index_leads_on_mobile_number", unique: true
    t.index ["source"], name: "index_leads_on_source"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "activities", "leads"
  add_foreign_key "activities", "users"
  add_foreign_key "follow_ups", "leads"
  add_foreign_key "follow_ups", "users"
  add_foreign_key "lead_stage_transitions", "lead_stages", column: "from_stage_id"
  add_foreign_key "lead_stage_transitions", "lead_stages", column: "to_stage_id"
  add_foreign_key "lead_stage_transitions", "leads"
  add_foreign_key "lead_stage_transitions", "users"
  add_foreign_key "leads", "lead_stages", column: "current_stage_id"
  add_foreign_key "leads", "users", column: "assigned_cre_id"
  add_foreign_key "leads", "users", column: "assigned_sales_exec_id"
  add_foreign_key "users", "roles"
end
