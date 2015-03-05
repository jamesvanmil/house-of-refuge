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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150304213736) do

  create_table "admissions", force: :cascade do |t|
    t.integer  "age"
    t.string   "alias"
    t.boolean  "appearance_bad"
    t.boolean  "appearance_good"
    t.string   "by_whom_committed"
    t.boolean  "can_read"
    t.boolean  "can_write"
    t.boolean  "complaint_of_father"
    t.boolean  "complaint_of_mother"
    t.boolean  "complaint_of_police"
    t.date     "date"
    t.string   "disposal"
    t.boolean  "father_drinks"
    t.boolean  "father_living"
    t.string   "for_what_committed"
    t.string   "gender"
    t.boolean  "had_regular_work"
    t.boolean  "has_step_father"
    t.boolean  "has_step_mother"
    t.integer  "history_number"
    t.string   "image_no"
    t.boolean  "mother_drinks"
    t.boolean  "mother_living"
    t.string   "name"
    t.text     "no_of_reader"
    t.integer  "no_of_times_in_refuge"
    t.string   "parentage"
    t.boolean  "played_truant"
    t.string   "religion"
    t.boolean  "swears"
    t.boolean  "uses_liquour"
    t.boolean  "uses_tobacco"
    t.string   "whereborn_city"
    t.string   "whereborn_country"
    t.string   "whereborn_state"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

end
