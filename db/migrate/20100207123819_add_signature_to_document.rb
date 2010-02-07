class AddSignatureToDocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :signature, :string
    change_column :documents, :signature, :string, :null => false
  end

  def self.down
    remove_column :documents, :signature
  end
end
