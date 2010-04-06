class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.string :location
      t.text :description

      t.timestamps
    end
    
    create_table :catalogs_events, :id => false do |t|
      t.string :catalog_id
      t.boolean :event_id
    end
    
    create_table :events_roles, :id => false do |t|
      t.string :event_id
      t.boolean :role_id
    end
    
    add_index :catalogs_events, [:catalog_id, :event_id]
    add_index :events_roles, [:event_id, :role_id]
  end

  def self.down
    drop_table :events
  end
end
