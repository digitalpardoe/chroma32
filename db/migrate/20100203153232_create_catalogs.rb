class CreateCatalogs < ActiveRecord::Migration
  def self.up
    create_table :catalogs do |t|
      t.string :name, :null => false
      t.integer :catalog_id

      t.timestamps
    end
  end

  def self.down
    drop_table :catalogs
  end
end
