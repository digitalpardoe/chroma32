class ModifyRolesProtected < ActiveRecord::Migration
  def self.up
    change_column :roles, :protected, :boolean, :default => false
  end

  def self.down
    change_column :roles, :protected, :boolean
  end
end
