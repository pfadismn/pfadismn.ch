class CreateAlumniAddresses < ActiveRecord::Migration
  def change
    create_table :alumni_addresses do |t|
      t.string :name
      t.string :vulgo
      t.string :email
      t.text :comment

      t.timestamps
    end
  end
end