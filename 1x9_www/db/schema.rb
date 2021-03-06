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

ActiveRecord::Schema.define(:version => 20081121213536) do

  create_table "controllers", :force => true do |t|
    t.string "title", :limit => 32, :null => false
    t.string "name",  :limit => 32, :null => false
  end

  add_index "controllers", ["title", "name"], :name => "title_name", :unique => true

  create_table "entries", :force => true do |t|
    t.text     "val"
    t.string   "addr"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entry_header", :force => true do |t|
    t.integer "entry_id"
    t.text    "name"
    t.string  "type",        :limit => 16
    t.integer "location_id"
  end

  add_index "entry_header", ["entry_id"], :name => "entry_id"

  create_table "entry_lines", :force => true do |t|
    t.text     "val"
    t.integer  "entry_id"
    t.integer  "line_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entry_lines", ["entry_id"], :name => "entry_id"

  create_table "entry_meta", :force => true do |t|
    t.integer "entry_id"
    t.integer "meta_id"
    t.string  "type",     :limit => 16
    t.string  "name",     :limit => 16
    t.text    "val"
  end

  add_index "entry_meta", ["entry_id"], :name => "entry_id"

  create_table "entry_words", :force => true do |t|
    t.string   "val",        :default => "", :null => false
    t.integer  "pos"
    t.integer  "line_id"
    t.integer  "entry_id"
    t.integer  "line_num"
    t.datetime "created_at"
  end

  add_index "entry_words", ["entry_id", "line_num", "pos", "created_at"], :name => "entry_id_line_num_pos_created_at", :unique => true
  add_index "entry_words", ["entry_id"], :name => "entry_id"
  add_index "entry_words", ["line_id"], :name => "line_id"

  create_table "groups", :force => true do |t|
    t.integer "location_id"
    t.string  "name",        :limit => 32, :default => "",    :null => false
    t.boolean "disabled",                  :default => false
  end

  add_index "groups", ["location_id"], :name => "location_id"
  add_index "groups", ["name"], :name => "name", :unique => true

  create_table "locations", :force => true do |t|
    t.string "name",    :limit => 32, :default => "", :null => false
    t.string "address", :limit => 32, :default => "", :null => false
  end

  add_index "locations", ["name", "address"], :name => "name_address", :unique => true

  create_table "permissions", :force => true do |t|
    t.integer "group_id",                         :null => false
    t.integer "controller_id",                    :null => false
    t.boolean "access_create", :default => false
    t.boolean "access_read",   :default => false
    t.boolean "access_update", :default => false
    t.boolean "access_delete", :default => false
  end

  add_index "permissions", ["controller_id"], :name => "controller_id"
  add_index "permissions", ["group_id", "controller_id"], :name => "group_id_controller_id", :unique => true
  add_index "permissions", ["group_id"], :name => "group_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.integer  "user_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.integer  "group_id"
    t.string   "username",      :limit => 64
    t.string   "password",      :limit => 32
    t.string   "name",          :limit => 32
    t.string   "email",         :limit => 64
    t.datetime "created_on"
    t.datetime "last_login_at"
    t.boolean  "disabled",                    :default => false
  end

  add_index "users", ["group_id"], :name => "group_id"
  add_index "users", ["username"], :name => "username", :unique => true

end
