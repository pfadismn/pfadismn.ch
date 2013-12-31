class AddAliasToMembers < ActiveRecord::Migration
  def change
    rename_column :members, :email, :alias
    add_column :members, :email, :string
  end
end
