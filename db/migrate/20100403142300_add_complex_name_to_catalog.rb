class AddComplexNameToCatalog < ActiveRecord::Migration
  def self.up
    add_column :catalogs, :complex_name, :string
  end

  def self.down
    remove_column :catalogs, :complex_name
  end
end
