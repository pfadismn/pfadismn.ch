class AddEmailToOus < ActiveRecord::Migration
  def change
    add_column :organisational_units, :email, :string
  end
end
