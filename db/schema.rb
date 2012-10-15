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

ActiveRecord::Schema.define(:version => 20121015010022) do

  create_table "mentor_teachers", :force => true do |t|
    t.string   "mailingaddress"
    t.string   "phonenumber"
    t.string   "email"
    t.string   "password"
    t.string   "school"
    t.string   "gradelevel"
    t.string   "classesteaching"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "preferences", :force => true do |t|
    t.integer  "student_id"
    t.integer  "timeslot_id"
    t.integer  "ranking"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "students", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "timeslots", :force => true do |t|
    t.time     "time"
    t.integer  "day"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "mentor_teacher_id"
  end

end
