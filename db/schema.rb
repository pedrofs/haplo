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

ActiveRecord::Schema.define(version: 20141202190632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "subdomain"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", force: true do |t|
    t.string   "action"
    t.text     "extra_info"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "api_logs", force: true do |t|
    t.string   "controller"
    t.string   "action"
    t.string   "ip_address"
    t.string   "path"
    t.string   "url"
    t.string   "params"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "request_method"
    t.integer  "response_status"
    t.text     "response_body"
    t.datetime "requested_at"
  end

  add_index "api_logs", ["user_id"], name: "index_api_logs_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "discussion_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["discussion_id"], name: "index_comments_on_discussion_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "discussions", force: true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "discussions", ["user_id"], name: "index_discussions_on_user_id", using: :btree

  create_table "favorite_discussions", force: true do |t|
    t.integer  "discussion_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorite_discussions", ["discussion_id"], name: "index_favorite_discussions_on_discussion_id", using: :btree
  add_index "favorite_discussions", ["user_id"], name: "index_favorite_discussions_on_user_id", using: :btree

  create_table "favorite_projects", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorite_projects", ["project_id"], name: "index_favorite_projects_on_project_id", using: :btree
  add_index "favorite_projects", ["user_id"], name: "index_favorite_projects_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "client"
    t.boolean  "archived",           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "targets", force: true do |t|
    t.integer  "discussion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "targetable_id"
    t.string   "targetable_type"
  end

  add_index "targets", ["discussion_id"], name: "index_targets_on_discussion_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.float    "estimated_time"
    t.float    "time_spent"
    t.integer  "progress"
    t.integer  "assigned_id"
    t.integer  "reporter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taskable_id"
    t.string   "taskable_type"
    t.integer  "priority"
    t.integer  "status"
    t.datetime "closed_at"
    t.boolean  "today"
  end

  add_index "tasks", ["assigned_id"], name: "index_tasks_on_assigned_id", using: :btree
  add_index "tasks", ["reporter_id"], name: "index_tasks_on_reporter_id", using: :btree

  create_table "timelogs", force: true do |t|
    t.datetime "started_at"
    t.datetime "stopped_at"
    t.text     "content"
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timelogs", ["task_id"], name: "index_timelogs_on_task_id", using: :btree
  add_index "timelogs", ["user_id"], name: "index_timelogs_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.integer  "role_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
