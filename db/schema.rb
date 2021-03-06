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

ActiveRecord::Schema.define(:version => 20100406180529) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "author"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs", :force => true do |t|
    t.string   "name",         :null => false
    t.integer  "catalog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "complex_name"
  end

  create_table "catalogs_events", :id => false, :force => true do |t|
    t.string  "catalog_id"
    t.boolean "event_id"
  end

  add_index "catalogs_events", ["catalog_id", "event_id"], :name => "index_catalogs_events_on_catalog_id_and_event_id"

  create_table "documents", :force => true do |t|
    t.string   "name",                            :null => false
    t.string   "extension"
    t.integer  "size",                            :null => false
    t.integer  "catalog_id",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content_type",                    :null => false
    t.string   "signature",                       :null => false
    t.boolean  "public",       :default => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "date"
    t.string   "location"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events_roles", :id => false, :force => true do |t|
    t.string  "event_id"
    t.boolean "role_id"
  end

  add_index "events_roles", ["event_id", "role_id"], :name => "index_events_roles_on_event_id_and_role_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.boolean  "hidden",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.string  "role_id"
    t.boolean "user_id"
  end

  add_index "roles_users", ["role_id", "user_id"], :name => "index_roles_users_on_role_id_and_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "resource"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",     :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
