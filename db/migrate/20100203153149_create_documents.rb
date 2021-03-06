class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string :name, :null => false
      t.string :extension
      t.integer :size, :null => false
      t.integer :catalog_id

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
