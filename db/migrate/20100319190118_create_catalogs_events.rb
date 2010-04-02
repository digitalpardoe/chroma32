class CreateCatalogsEvents < ActiveRecord::Migration
  def self.up
    create_table :catalogs_events, :id => false do |t|
      t.string :catalog_id
      t.boolean :event_id
    end
    
    add_index :catalogs_events, [:catalog_id, :event_id]
  end

  def self.down
    drop_table :catalogs_events
  end
end
