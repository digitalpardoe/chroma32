class CreateRolesUsers < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.string :role_id
      t.boolean :user_id
    end
    
    add_index :roles_users, [:role_id, :user_id]
  end

  def self.down
    drop_table :roles_users
  end
end
