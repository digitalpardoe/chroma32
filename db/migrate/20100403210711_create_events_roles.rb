class CreateEventsRoles < ActiveRecord::Migration
  def self.up
    create_table :events_roles, :id => false do |t|
      t.string :event_id
      t.boolean :role_id
    end
    
    add_index :events_roles, [:event_id, :role_id]
  end

  def self.down
    drop_table :events_roles
  end
end
