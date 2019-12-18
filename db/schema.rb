# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_18_032029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_conditions", force: :cascade do |t|
    t.text "method"
    t.text "value"
    t.text "scenario"
    t.bigint "question_id", null: false
    t.bigint "condition_question_id"
    t.bigint "row"
    t.text "relation"
    t.bigint "question_answer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "sql_format"
    t.index ["question_answer_id"], name: "index_answer_conditions_on_question_answer_id"
    t.index ["question_id"], name: "index_answer_conditions_on_question_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "companies", force: :cascade do |t|
    t.text "name"
    t.text "image_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "condition_links", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "condition_id", null: false
    t.text "relation"
    t.bigint "other_condition_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["condition_id"], name: "index_condition_links_on_condition_id"
    t.index ["question_id"], name: "index_condition_links_on_question_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.text "method"
    t.text "value"
    t.text "scenario"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "question_id"
    t.bigint "condition_question_id"
    t.bigint "row", default: 0
    t.text "relation"
    t.text "condition_hash"
  end

  create_table "group_error_logics", force: :cascade do |t|
    t.bigint "question_group_id", null: false
    t.text "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_group_id"], name: "index_group_error_logics_on_question_group_id"
  end

  create_table "question_answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.text "code"
    t.bigint "value"
    t.text "exact_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.boolean "display_input_box_1"
    t.boolean "display_input_box_2"
    t.text "input_box_1_label"
    t.text "input_box_2_label"
    t.text "input_box_1_type"
    t.text "input_box_2_type"
    t.jsonb "other_language", default: {}
    t.index ["question_id"], name: "index_question_answers_on_question_id"
  end

  create_table "question_groups", force: :cascade do |t|
    t.bigint "position"
    t.text "name"
    t.text "description"
    t.bigint "survey_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "any_error", default: false
    t.boolean "verify_error", default: false
    t.index ["survey_id"], name: "index_question_groups_on_survey_id"
  end

  create_table "question_other_languages", force: :cascade do |t|
    t.text "description"
    t.bigint "survey_language_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_question_other_languages_on_question_id"
    t.index ["survey_language_id"], name: "index_question_other_languages_on_survey_language_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "question_group_id", null: false
    t.text "q_type"
    t.text "code"
    t.text "description"
    t.text "help"
    t.boolean "mandatory"
    t.bigint "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "image"
    t.text "image_data"
    t.bigint "limit"
    t.bigint "survey_id"
    t.bigint "survey_position"
    t.text "structure"
    t.boolean "enable_other_1", default: false
    t.boolean "enable_other_2", default: false
    t.jsonb "other_language", default: "{}"
    t.text "logic"
    t.text "question_desc"
    t.text "desc_question_code"
    t.boolean "randomize"
    t.bigint "column"
    t.jsonb "help_other_language", default: {}
    t.jsonb "question_desc_other_language", default: {}
    t.index ["question_group_id"], name: "index_questions_on_question_group_id"
  end

  create_table "quota", force: :cascade do |t|
    t.text "name"
    t.bigint "survey_id", null: false
    t.bigint "limit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "complete_count", default: 0
    t.text "message"
    t.text "url_redirection"
    t.index ["survey_id"], name: "index_quota_on_survey_id"
  end

  create_table "quota_members", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "answer_value"
    t.bigint "quota_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quota_id"], name: "index_quota_members_on_quota_id"
  end

  create_table "subquestions", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.text "code"
    t.bigint "value"
    t.text "exact_value"
    t.bigint "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "other_language", default: {}
    t.index ["question_id"], name: "index_subquestions_on_question_id"
  end

  create_table "survey_answers", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.bigint "question_id", null: false
    t.string "value"
    t.text "session"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.time "time_per_question"
    t.index ["question_id"], name: "index_survey_answers_on_question_id"
    t.index ["survey_id"], name: "index_survey_answers_on_survey_id"
  end

  create_table "survey_languages", force: :cascade do |t|
    t.text "name"
    t.bigint "survey_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_survey_languages_on_survey_id"
  end

  create_table "survey_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "survey_id", null: false
    t.bigint "question_id", null: false
    t.text "string"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_survey_sessions_on_question_id"
    t.index ["survey_id"], name: "index_survey_sessions_on_survey_id"
    t.index ["user_id"], name: "index_survey_sessions_on_user_id"
  end

  create_table "survey_settings", force: :cascade do |t|
    t.boolean "enable_pdpa"
    t.text "pdpa_message"
    t.text "pdpa_error_message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "survey_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean "enable_question_code", default: false
    t.boolean "enable_group_code", default: false
    t.boolean "enable_answer_code", default: false
    t.index ["survey_id"], name: "index_survey_settings_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "welcome_message"
    t.text "end_message"
    t.boolean "show_intro_screen"
    t.text "final_button_text"
    t.text "final_button_url"
    t.boolean "show_final_button", default: false
    t.text "start_button_text"
    t.boolean "final_button_to_start", default: false
    t.text "image_data"
    t.text "status"
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "user_type", default: "user"
    t.string "name"
    t.string "phone_number"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answer_conditions", "question_answers"
  add_foreign_key "answer_conditions", "questions"
  add_foreign_key "condition_links", "conditions"
  add_foreign_key "condition_links", "questions"
  add_foreign_key "group_error_logics", "question_groups"
  add_foreign_key "question_answers", "questions"
  add_foreign_key "question_groups", "surveys"
  add_foreign_key "question_other_languages", "questions"
  add_foreign_key "question_other_languages", "survey_languages"
  add_foreign_key "questions", "question_groups"
  add_foreign_key "quota", "surveys"
  add_foreign_key "quota_members", "quota", column: "quota_id"
  add_foreign_key "subquestions", "questions"
  add_foreign_key "survey_answers", "questions"
  add_foreign_key "survey_answers", "surveys"
  add_foreign_key "survey_languages", "surveys"
  add_foreign_key "survey_sessions", "questions"
  add_foreign_key "survey_sessions", "surveys"
  add_foreign_key "survey_sessions", "users"
  add_foreign_key "survey_settings", "surveys"
  add_foreign_key "surveys", "users"
  add_foreign_key "users", "companies"
end
