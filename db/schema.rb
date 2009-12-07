# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090913193600) do

  create_table "bugs", :force => true do |t|
    t.integer  "defect_id"
    t.string   "defect_type"
    t.string   "priority"
    t.text     "summary"
    t.string   "developer"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "estimate"
    t.date     "planned_completion_date"
    t.integer  "developer_id"
    t.integer  "reviewer_id"
    t.integer  "release_id"
    t.integer  "status_id"
    t.boolean  "reviewed"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "commenter_id"
    t.string   "status"
    t.integer  "bug_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment_type"
  end

  create_table "members", :force => true do |t|
    t.string   "employee_id"
    t.string   "name"
    t.string   "contact_number"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.boolean  "admin",          :default => false
    t.boolean  "active",         :default => true
  end

  create_table "releases", :force => true do |t|
    t.string   "release_number"
    t.datetime "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "code"
    t.string   "description"
    t.string   "category"
    t.boolean  "admin_only",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
