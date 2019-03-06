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

ActiveRecord::Schema.define(version: 20190306161341) do

  create_table "instruments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ins_name_ja"
    t.string   "ins_name_en"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
    t.index ["instructor_id"], name: "index_lessons_on_instructor_id", using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "send_user_id"
    t.integer  "receive_user_id"
    t.string   "content"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["receive_user_id"], name: "index_messages_on_receive_user_id", using: :btree
    t.index ["send_user_id"], name: "index_messages_on_send_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "lesson_plans", "lessons"
  add_foreign_key "lessons", "users", column: "instructor_id"
  add_foreign_key "messages", "users", column: "receive_user_id"
  add_foreign_key "messages", "users", column: "send_user_id"
end
