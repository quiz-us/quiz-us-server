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

ActiveRecord::Schema.define(version: 20190813154207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "teacher_id"
    t.integer  "standards_chart_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["standards_chart_id"], name: "index_courses_on_standards_chart_id", using: :btree
    t.index ["teacher_id"], name: "index_courses_on_teacher_id", using: :btree
  end

  create_table "decks", force: :cascade do |t|
    t.date     "release_date"
    t.string   "name"
    t.text     "description"
    t.integer  "teacher_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["teacher_id"], name: "index_decks_on_teacher_id", using: :btree
  end

  create_table "decks_questions", id: false, force: :cascade do |t|
    t.integer "deck_id",     null: false
    t.integer "question_id", null: false
    t.index ["deck_id", "question_id"], name: "index_decks_questions_on_deck_id_and_question_id", using: :btree
    t.index ["question_id", "deck_id"], name: "index_decks_questions_on_question_id_and_deck_id", using: :btree
  end

  create_table "enrollments", id: false, force: :cascade do |t|
    t.integer "period_id",  null: false
    t.integer "student_id", null: false
    t.index ["period_id", "student_id"], name: "index_enrollments_on_period_id_and_student_id", using: :btree
    t.index ["student_id", "period_id"], name: "index_enrollments_on_student_id_and_period_id", using: :btree
  end

  create_table "periods", force: :cascade do |t|
    t.string   "name"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_periods_on_course_id", using: :btree
  end

  create_table "question_options", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "option_text"
    t.boolean  "correct"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_question_options_on_question_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.text     "question_text"
    t.string   "question_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "question_node", null: false
  end

  create_table "questions_standards", id: false, force: :cascade do |t|
    t.integer "question_id", null: false
    t.integer "standard_id", null: false
    t.index ["question_id", "standard_id"], name: "index_questions_standards_on_question_id_and_standard_id", using: :btree
    t.index ["standard_id", "question_id"], name: "index_questions_standards_on_standard_id_and_question_id", using: :btree
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "question_option_id"
    t.text     "response_text"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["question_option_id"], name: "index_responses_on_question_option_id", using: :btree
    t.index ["student_id"], name: "index_responses_on_student_id", using: :btree
  end

  create_table "standards", force: :cascade do |t|
    t.integer  "standards_chart_id"
    t.string   "description"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "standards_category_id", null: false
    t.string   "title"
    t.string   "meta"
    t.index ["standards_chart_id"], name: "index_standards_on_standards_chart_id", using: :btree
  end

  create_table "standards_categories", force: :cascade do |t|
    t.string   "title",              null: false
    t.text     "description"
    t.integer  "standards_chart_id", null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["standards_chart_id"], name: "index_standards_categories_on_standards_chart_id", using: :btree
  end

  create_table "standards_charts", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "tag_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "jti",                                 null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_teachers_on_email", unique: true, using: :btree
    t.index ["jti"], name: "index_teachers_on_jti", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "courses", "standards_charts"
  add_foreign_key "courses", "teachers"
  add_foreign_key "decks", "teachers"
  add_foreign_key "periods", "courses"
  add_foreign_key "question_options", "questions"
  add_foreign_key "responses", "question_options"
  add_foreign_key "responses", "students"
  add_foreign_key "standards", "standards_charts"
end
