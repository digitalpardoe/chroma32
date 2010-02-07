class ModifyDocumentCatalodId < ActiveRecord::Migration
  def self.up
    change_column :documents, :catalog_id, :integer, :null => false
  end

  def self.down
    change_column :documents, :catalog_id, :integer, :null => true
  end
end
