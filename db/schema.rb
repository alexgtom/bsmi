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

ActiveRecord::Schema.define(:version => 20121205113331) do

  create_table "advisors", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cal_courses", :force => true do |t|
    t.string   "name"
    t.text     "timeslots"
    t.string   "school_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "semester_id"
  end

  create_table "cal_courses_cal_faculties", :id => false, :force => true do |t|
    t.integer "cal_course_id"
    t.integer "cal_faculty_id"
  end

  create_table "cal_courses_students", :id => false, :force => true do |t|
    t.integer "cal_course_id"
    t.integer "student_id"
  end

  add_index "cal_courses_students", ["cal_course_id", "student_id"], :name => "index_cal_courses_students_on_cal_course_id_and_student_id"
  add_index "cal_courses_students", ["student_id", "cal_course_id"], :name => "index_cal_courses_students_on_student_id_and_cal_course_id"

  create_table "cal_faculties", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cal_faculties_semesters", :id => false, :force => true do |t|
    t.integer "cal_faculty_id"
    t.integer "semester_id"
  end

  add_index "cal_faculties_semesters", ["cal_faculty_id", "semester_id"], :name => "index_cal_faculties_semesters_on_cal_faculty_id_and_semester_id"
  add_index "cal_faculties_semesters", ["semester_id", "cal_faculty_id"], :name => "index_cal_faculties_semesters_on_semester_id_and_cal_faculty_id"

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "grade"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "cal_course_id"
  end

  create_table "deadlines", :force => true do |t|
    t.string   "title"
    t.text     "summary"
    t.datetime "due_date"
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

  create_table "matchings", :force => true do |t|
    t.integer  "student_id"
    t.integer  "timeslot_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "ranking"
  end

  create_table "mentor_teachers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "school_id"
  end

  create_table "mentor_teachers_semesters", :id => false, :force => true do |t|
    t.integer "mentor_teacher_id"
    t.integer "semester_id"
  end

  add_index "mentor_teachers_semesters", ["mentor_teacher_id", "semester_id"], :name => "index_mt_s"
  add_index "mentor_teachers_semesters", ["semester_id", "mentor_teacher_id"], :name => "inded_s_mt"

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
    t.integer  "district_id"
  end

  create_table "semesters", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "year"
    t.integer  "registration_deadline_id"
    t.string   "status"
    t.boolean  "matchings_performed",      :default => false
  end

  create_table "semesters_students", :id => false, :force => true do |t|
    t.integer "student_id"
    t.integer "semester_id"
  end

  add_index "semesters_students", ["semester_id", "student_id"], :name => "index_semesters_students_on_semester_id_and_student_id"
  add_index "semesters_students", ["student_id", "semester_id"], :name => "index_semesters_students_on_student_id_and_semester_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

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
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.time     "end_time"
    t.integer  "mentor_teacher_id"
    t.integer  "max_num_assistants", :default => 1
    t.integer  "course_id"
    t.integer  "cal_course_id"
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
