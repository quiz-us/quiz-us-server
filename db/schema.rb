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

ActiveRecord::Schema.define(version: 2019_08_29_144151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.bigint "deck_id", null: false
    t.datetime "due"
    t.text "instructions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "period_id", null: false
    t.index ["deck_id"], name: "index_assignments_on_deck_id"
    t.index ["due"], name: "index_assignments_on_due"
    t.index ["period_id"], name: "index_assignments_on_period_id"
  end

  create_table "courses", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "teacher_id"
    t.integer "standards_chart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["standards_chart_id"], name: "index_courses_on_standards_chart_id"
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "decks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "owner_type"
    t.bigint "owner_id"
    t.index ["owner_type", "owner_id"], name: "index_decks_on_owner_type_and_owner_id"
  end

  create_table "decks_questions", force: :cascade do |t|
    t.integer "deck_id", null: false
    t.integer "question_id", null: false
    t.integer "num_consecutive_correct", default: 0
    t.integer "total_correct", default: 0
    t.integer "total_attempts", default: 0
    t.float "e_factor", default: 2.5
    t.datetime "next_due"
    t.index ["deck_id", "question_id"], name: "by_deck_and_question", unique: true
    t.index ["deck_id", "question_id"], name: "index_decks_questions_on_deck_id_and_question_id"
    t.index ["question_id", "deck_id"], name: "index_decks_questions_on_question_id_and_deck_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "period_id", null: false
    t.integer "student_id", null: false
    t.index ["period_id", "student_id"], name: "by_period_and_student", unique: true
    t.index ["period_id", "student_id"], name: "index_enrollments_on_period_id_and_student_id"
    t.index ["student_id", "period_id"], name: "index_enrollments_on_student_id_and_period_id"
  end

  create_table "periods", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_periods_on_course_id"
  end

  create_table "question_options", id: :serial, force: :cascade do |t|
    t.integer "question_id"
    t.string "option_text"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "rich_text", default: {}
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.text "question_text"
    t.string "question_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "rich_text", default: {}
  end

  create_table "questions_standards", force: :cascade do |t|
    t.integer "question_id", null: false
    t.integer "standard_id", null: false
    t.index ["question_id", "standard_id"], name: "by_question_and_standard", unique: true
    t.index ["question_id", "standard_id"], name: "index_questions_standards_on_question_id_and_standard_id"
    t.index ["standard_id", "question_id"], name: "index_questions_standards_on_standard_id_and_question_id"
  end

  create_table "responses", id: :serial, force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "question_option_id"
    t.text "response_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "assignment_id"
    t.integer "question_id", null: false
    t.integer "self_grade"
    t.boolean "mc_correct"
    t.index ["question_option_id"], name: "index_responses_on_question_option_id"
    t.index ["student_id"], name: "index_responses_on_student_id"
  end

  create_table "standards", id: :serial, force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "standards_category_id", null: false
    t.string "title", null: false
    t.string "meta"
    t.index ["standards_category_id", "title"], name: "index_standards_on_standards_category_id_and_title", unique: true
    t.index ["standards_category_id"], name: "index_standards_on_standards_category_id"
    t.index ["title"], name: "index_standards_on_title"
  end

  create_table "standards_categories", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "standards_chart_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["standards_chart_id", "title"], name: "index_standards_categories_on_standards_chart_id_and_title", unique: true
    t.index ["standards_chart_id"], name: "index_standards_categories_on_standards_chart_id"
    t.index ["title"], name: "index_standards_categories_on_title"
  end

  create_table "standards_charts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", id: :serial, force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "jti", null: false
    t.string "qr_code", default: "", null: false
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["jti"], name: "index_students_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "question_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id", "question_id"], name: "by_tag_and_question", unique: true
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "teachers", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "jti", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["jti"], name: "index_teachers_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
  end

  create_table "tokens", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.string "value", null: false
    t.boolean "expired", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_tokens_on_student_id"
    t.index ["value"], name: "index_tokens_on_value"
  end

  add_foreign_key "courses", "standards_charts"
  add_foreign_key "courses", "teachers"
  add_foreign_key "periods", "courses"
  add_foreign_key "question_options", "questions"
  add_foreign_key "responses", "question_options"
  add_foreign_key "responses", "students"
  add_foreign_key "standards", "standards_categories"
  add_foreign_key "standards_categories", "standards_charts"
end
