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

ActiveRecord::Schema.define(version: 20190407093448) do

  create_table "available_instruments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "lesson_id"
    t.integer  "instrument_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["instrument_id"], name: "index_available_instruments_on_instrument_id", using: :btree
    t.index ["lesson_id", "instrument_id"], name: "index_available_instruments_on_lesson_id_and_instrument_id", unique: true, using: :btree
    t.index ["lesson_id"], name: "index_available_instruments_on_lesson_id", using: :btree
  end

  create_table "available_subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "lesson_id"
    t.integer  "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id", "subject_id"], name: "index_available_subjects_on_lesson_id_and_subject_id", unique: true, using: :btree
    t.index ["lesson_id"], name: "index_available_subjects_on_lesson_id", using: :btree
    t.index ["subject_id"], name: "index_available_subjects_on_subject_id", using: :btree
  end

  create_table "favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["from_user_id", "to_user_id"], name: "index_favorites_on_from_user_id_and_to_user_id", unique: true, using: :btree
    t.index ["from_user_id"], name: "index_favorites_on_from_user_id", using: :btree
    t.index ["to_user_id"], name: "index_favorites_on_to_user_id", using: :btree
  end

  create_table "instruments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ins_name_ja"
    t.string   "ins_name_en"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "interested_instruments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "instrument_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["instrument_id"], name: "index_interested_instruments_on_instrument_id", using: :btree
    t.index ["user_id", "instrument_id"], name: "index_interested_instruments_on_user_id_and_instrument_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_interested_instruments_on_user_id", using: :btree
  end

  create_table "interested_subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_interested_subjects_on_subject_id", using: :btree
    t.index ["user_id", "subject_id"], name: "index_interested_subjects_on_user_id_and_subject_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_interested_subjects_on_user_id", using: :btree
  end

  create_table "languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "lang_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lesson_plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "lesson_id"
    t.integer  "minute"
    t.string   "location_broad"
    t.string   "location_narrow"
    t.integer  "price_yen"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["lesson_id"], name: "index_lesson_plans_on_lesson_id", using: :btree
  end

  create_table "lessons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "instructor_id"
    t.string   "youtube_url1"
    t.string   "youtube_url2"
    t.string   "youtube_url3"
    t.text     "biography",     limit: 65535
    t.text     "advantage",     limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.float    "average_rate",  limit: 24
    t.index ["instructor_id"], name: "index_lessons_on_instructor_id", using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "send_user_id"
    t.integer  "receive_user_id"
    t.text     "content",         limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["receive_user_id"], name: "index_messages_on_receive_user_id", using: :btree
    t.index ["send_user_id"], name: "index_messages_on_send_user_id", using: :btree
  end

  create_table "point_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.integer  "amount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["from_user_id"], name: "index_point_histories_on_from_user_id", using: :btree
    t.index ["to_user_id"], name: "index_point_histories_on_to_user_id", using: :btree
  end

  create_table "points", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "current_point"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id"], name: "index_points_on_user_id", using: :btree
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.integer  "rate"
    t.text     "comment",      limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["from_user_id", "to_user_id"], name: "index_reviews_on_from_user_id_and_to_user_id", unique: true, using: :btree
    t.index ["from_user_id"], name: "index_reviews_on_from_user_id", using: :btree
    t.index ["to_user_id"], name: "index_reviews_on_to_user_id", using: :btree
  end

  create_table "subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "subj_name_ja"
    t.string   "subj_name_en"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                           null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name"
    t.string   "bank"
    t.string   "branch"
    t.string   "account_type"
    t.string   "account_number"
    t.string   "account_holder"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer  "access_count_to_reset_password_page", default: 0
    t.integer  "failed_logins_count",                 default: 0
    t.datetime "lock_expires_at"
    t.string   "unlock_token"
    t.index ["activation_token"], name: "index_users_on_activation_token", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", using: :btree
  end

  create_table "users_languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "language_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["language_id"], name: "index_users_languages_on_language_id", using: :btree
    t.index ["user_id", "language_id"], name: "index_users_languages_on_user_id_and_language_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_users_languages_on_user_id", using: :btree
  end

  add_foreign_key "available_instruments", "instruments"
  add_foreign_key "available_instruments", "lessons"
  add_foreign_key "available_subjects", "lessons"
  add_foreign_key "available_subjects", "subjects"
  add_foreign_key "favorites", "users", column: "from_user_id"
  add_foreign_key "favorites", "users", column: "to_user_id"
  add_foreign_key "interested_instruments", "instruments"
  add_foreign_key "interested_instruments", "users"
  add_foreign_key "interested_subjects", "subjects"
  add_foreign_key "interested_subjects", "users"
  add_foreign_key "lesson_plans", "lessons"
  add_foreign_key "lessons", "users", column: "instructor_id"
  add_foreign_key "messages", "users", column: "receive_user_id"
  add_foreign_key "messages", "users", column: "send_user_id"
  add_foreign_key "point_histories", "users", column: "from_user_id"
  add_foreign_key "point_histories", "users", column: "to_user_id"
  add_foreign_key "points", "users"
  add_foreign_key "reviews", "users", column: "from_user_id"
  add_foreign_key "reviews", "users", column: "to_user_id"
  add_foreign_key "users_languages", "languages"
  add_foreign_key "users_languages", "users"
end
