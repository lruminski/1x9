require 'db/migration_helper'
class CreateDatabase < ActiveRecord::Migration
  extend MigrationHelper
  def self.up

    create_table "entries", :force => true do |t|
      t.text      "val"
      t.string    "addr",                       :limit => 255
      t.integer   "user_id",                    :unsigned => true
      t.datetime  "created_at"
      t.datetime  "updated_at"
    end

    create_table "entry_lines", :force => true do |t|
      t.text      "val"
      t.integer   "entry_id",                   :unsigned => true
      t.integer   "line_num",                   :unsigned => true
      t.datetime  "created_at"
      t.datetime  "updated_at"
    end
    add_foreign_key 'entry_lines', 'entry_id', 'entries', 'ON DELETE SET NULL'
    
    create_table "entry_words", :force => true do |t|
      t.string    "val",                        :limit => 255, :default => "", :null => false
      t.integer   "pos",                        :unsigned => true  
      t.integer   "line_id",                    :unsigned => true
      t.integer   "entry_id",                   :unsigned => true
      t.integer   "line_num",                   :unsigned => true
      t.datetime  "created_at"
    end
    add_foreign_key 'entry_words', 'entry_id', 'entries', 'ON DELETE SET NULL'
    add_foreign_key 'entry_words', 'line_id', 'entry_lines', 'ON DELETE CASCADE'
    add_index "entry_words", ["entry_id", "line_num", "pos", "created_at"], :name => "entry_id_line_num_pos_created_at", :unique => true
    
    
    create_table "entry_header", :force => true do |t|
      t.integer   "entry_id",                   :unsigned => true
      t.text      "name",                       :limit => 255
      t.string    "type",                       :limit => 16
      t.integer   "location_id",                :unsigned => true
    end
    add_foreign_key 'entry_header', 'entry_id', 'entries', 'ON DELETE CASCADE'
    
    create_table "entry_meta", :force => true do |t|
      t.integer   "entry_id",                   :unsigned => true
      t.integer   "meta_id",                    :unsigned => true      
      t.string    "type",                       :limit => 16
      t.string    "name",                       :limit => 16
      t.text      "val"
    end
    add_foreign_key 'entry_meta', 'entry_id', 'entries', 'ON DELETE CASCADE'
    
    create_table "locations", :force => true do |t|
      t.string    "name",                       :limit => 32, :default => "", :null => false
      t.string    "address",                    :limit => 32, :default => "", :null => false
    end
    add_index "locations", ["name", "address"], :name => "name_address", :unique => true

    create_table "groups", :force => true do |t|
      t.integer "location_id"                  
      t.string  "name",                         :limit => 32, :default => "", :null => false
      t.boolean "disabled",                     :default => false
    end
    add_index "groups", ["name"], :name => "name", :unique => true
    add_foreign_key 'groups', 'location_id', 'locations', 'ON DELETE SET NULL'

    create_table "users", :force => true do |t|
      t.integer   "group_id"
      t.string    "username",                     :limit => 64
      t.string    "password",                     :limit => 32
      t.string    "name",                         :limit => 32
      t.string    "email",                        :limit => 64
      t.datetime  "created_on"                   
      t.datetime  "last_login_at"     
      t.boolean   "disabled",                     :default => false                 
    end
    add_index "users", ["username"], :name => "username", :unique => true
    add_foreign_key 'users', 'group_id', 'groups', 'ON DELETE SET NULL'

    create_table "controllers", :force => true do |t|
      t.string    "title",                        :limit => 32, :null => false
      t.string    "name",                         :limit => 32, :null => false
    end
    add_index "controllers", ["title", "name"], :name => "title_name", :unique => true

    create_table "permissions", :force => true do |t|
      t.integer "group_id",                     :null => false
      t.integer "controller_id",                :null => false
      t.boolean "access_create",                :default => false
      t.boolean "access_read",                  :default => false
      t.boolean "access_update",                :default => false
      t.boolean "access_delete",                :default => false
    end
    add_index "permissions", ["group_id", "controller_id"], :name => "group_id_controller_id", :unique => true
    add_foreign_key 'permissions', 'group_id', 'groups', 'ON DELETE CASCADE'
    add_foreign_key 'permissions', 'controller_id', 'controllers', 'ON DELETE CASCADE'
    
    create_table "sessions" do |t|
      t.string  "session_id",                   :null => false
      t.integer "user_id",                      :unsigned => true
      t.text    "data"
      t.timestamps
    end
    add_index "sessions", "session_id"
    add_index "sessions", "updated_at"

  end
  
  def self.down
    drop_table "entry_words"
    drop_table "entry_lines"
    drop_table "entries"
    drop_table "entry_header"
    drop_table "entry_meta"
    drop_table "locations"
    drop_table "groups"
    drop_table "users"
    drop_table "controllers"
    drop_table "permissions"
    drop_table "sessions"
  end
end
