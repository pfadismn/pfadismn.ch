class AddEmailToOus < ActiveRecord::Migration[4.2]
  def change
    add_column :organisational_units, :email, :string
  end
end
