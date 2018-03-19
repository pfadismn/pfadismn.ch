class AddAliasToMembers < ActiveRecord::Migration[4.2]
  def change
    rename_column :members, :email, :alias
    add_column :members, :email, :string
  end
end
