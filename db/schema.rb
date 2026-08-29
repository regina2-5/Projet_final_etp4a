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

ActiveRecord::Schema[8.1].define(version: 2026_01_01_000014) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "applications", force: :cascade do |t|
    t.text "cover_letter"
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.string "status", default: "pending"
    t.bigint "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_applications_on_job_id"
    t.index ["student_id", "job_id"], name: "index_applications_on_student_id_and_job_id", unique: true
    t.index ["student_id"], name: "index_applications_on_student_id"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "kind"
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.string "sector"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.boolean "validated", default: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.boolean "active", default: true
    t.bigint "category_id"
    t.bigint "company_id", null: false
    t.string "contract_type"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "location"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_jobs_on_category_id"
    t.index ["company_id"], name: "index_jobs_on_company_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.boolean "read", default: false
    t.bigint "receiver_id", null: false
    t.bigint "sender_id", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.bigint "notifiable_id"
    t.string "notifiable_type"
    t.boolean "read", default: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_skills_on_name", unique: true
  end

  create_table "student_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "level", default: 1
    t.bigint "skill_id", null: false
    t.bigint "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_student_skills_on_skill_id"
    t.index ["student_id", "skill_id"], name: "index_student_skills_on_student_id_and_skill_id", unique: true
    t.index ["student_id"], name: "index_student_skills_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "cv_url"
    t.string "first_name"
    t.string "last_name"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "trainers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "expertise"
    t.string "first_name"
    t.string "last_name"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_trainers_on_user_id"
  end

  create_table "training_registrations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "status", default: "registered"
    t.bigint "student_id", null: false
    t.bigint "training_id", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id", "training_id"], name: "idx_unique_student_training", unique: true
    t.index ["student_id"], name: "index_training_registrations_on_student_id"
    t.index ["training_id"], name: "index_training_registrations_on_training_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.integer "capacity"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.text "description"
    t.datetime "ends_at"
    t.datetime "starts_at"
    t.string "title", null: false
    t.bigint "trainer_id", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_trainings_on_category_id"
    t.index ["trainer_id"], name: "index_trainings_on_trainer_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.bigint "role_id", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "applications", "jobs"
  add_foreign_key "applications", "students"
  add_foreign_key "companies", "users"
  add_foreign_key "jobs", "categories"
  add_foreign_key "jobs", "companies"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "student_skills", "skills"
  add_foreign_key "student_skills", "students"
  add_foreign_key "students", "users"
  add_foreign_key "trainers", "users"
  add_foreign_key "training_registrations", "students"
  add_foreign_key "training_registrations", "trainings"
  add_foreign_key "trainings", "categories"
  add_foreign_key "trainings", "trainers"
  add_foreign_key "users", "roles"
end
