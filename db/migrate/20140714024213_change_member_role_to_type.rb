class ChangeMemberRoleToType < ActiveRecord::Migration
  def change
    remove_column :members, :role
    add_column :members, :type, :string
  end
end
