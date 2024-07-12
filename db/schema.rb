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

ActiveRecord::Schema[7.1].define(version: 2024_07_12_081749) do
  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.integer "reps"
    t.integer "sets"
    t.string "status"
    t.integer "workout_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "weight"
    t.index ["workout_id"], name: "index_exercises_on_workout_id"
  end

  create_table "nutrition_plans", force: :cascade do |t|
    t.decimal "weight"
    t.decimal "height"
    t.decimal "age"
    t.decimal "bodyfat"
    t.string "lifestyle"
    t.string "protein"
    t.string "fat"
    t.string "carb"
    t.string "goal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_nutrition_plans_on_user_id"
  end

  create_table "nutritions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_nutritions_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "stats", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.decimal "value"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stats_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "workout_plans", force: :cascade do |t|
    t.decimal "weight"
    t.decimal "height"
    t.decimal "age"
    t.decimal "bodyfat"
    t.string "lifestyle"
    t.string "frequency"
    t.string "volume"
    t.integer "duration"
    t.string "intensity"
    t.string "goal"
    t.string "type_of_training"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_workout_plans_on_user_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "exercises", "workouts"
  add_foreign_key "nutrition_plans", "users"
  add_foreign_key "nutritions", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "stats", "users"
  add_foreign_key "workout_plans", "users"
  add_foreign_key "workouts", "users"
end
