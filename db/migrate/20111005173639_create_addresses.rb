class CreateAddresses < ActiveRecord::Migration[4.2]
  def change
    create_table :addresses do |t|
      t.integer :addressable_id
      t.string :addressable_type
      t.string :line1
      t.string :line2
      t.string :zip
      t.string :place
      t.string :country

      t.timestamps
    end
  end
end
