class RenameProtectedToHiddenOnRoles < ActiveRecord::Migration
  def self.up
    rename_column :roles, :protected, :hidden
  end

  def self.down
    rename_column :roles, :hidden, :protected
  end
end
