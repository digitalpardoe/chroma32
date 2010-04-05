class AddPublicToDocuments < ActiveRecord::Migration
  def self.up
    add_column :documents, :public, :boolean, :default => false
  end

  def self.down
    remove_column :documents, :public
  end
end
