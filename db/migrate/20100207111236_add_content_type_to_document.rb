class AddContentTypeToDocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :content_type, :string
    change_column :documents, :content_type, :string, :null => false
  end

  def self.down
    remove_column :documents, :content_type
  end
end
