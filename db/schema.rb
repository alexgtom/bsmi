# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121104052507) do

  create_table "advisors", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "grade"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "districts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invites", :force => true do |t|
    t.string   "email"
    t.string   "invite_code", :limit => 40
    t.datetime "invited_at"
    t.datetime "redeemed_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "owner_type"
  end

  add_index "invites", ["id", "email"], :name => "index_invites_on_id_and_email"
  add_index "invites", ["id", "invite_code"], :name => "index_invites_on_id_and_invite_code"

  create_table "mentor_teachers", :force => true do |t|
    t.string   "mailing_address"
    t.string   "phone_number"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "school_id"
  end

  create_table "preferences", :force => true do |t|
    t.integer  "student_id"
    t.integer  "timeslot_id"
    t.integer  "ranking"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "level"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "district_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

  create_table "students", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "students_timeslots", :id => false, :force => true do |t|
    t.integer "timeslot_id"
    t.integer "student_id"
  end

  create_table "timeslots", :force => true do |t|
    t.time     "start_time"
    t.integer  "day"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.time     "end_time"
    t.integer  "mentor_teacher_id"
    t.integer  "max_num_assistants"
    t.integer  "course_id"
  end

  create_table "users", :force => true do |t|
    t.string   "phone_number",                       :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "email",                              :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
  end

end
