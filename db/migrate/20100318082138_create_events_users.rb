class CreateEventsUsers < ActiveRecord::Migration
  def self.up
    create_table :events_users, :id => false do |t|
      t.string :event_id
      t.boolean :user_id
    end
    
    add_index :events_users, [:event_id, :user_id]
  end

  def self.down
    drop_table :events_users
  end
end
