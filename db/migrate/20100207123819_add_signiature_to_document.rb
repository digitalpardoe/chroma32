class AddSigniatureToDocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :signiature, :string
    change_column :documents, :signiature, :string, :null => false
  end

  def self.down
    remove_column :documents, :signiature
  end
end
