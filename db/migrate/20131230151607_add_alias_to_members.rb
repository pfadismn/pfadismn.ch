class AddAliasToMembers < ActiveRecord::Migration
  def change
    rename_column :members, :email, :login
    add_column :members, :email, :string
  end
end
