class CreatePhoneNumbers < ActiveRecord::Migration[4.2]
  def change
    create_table :phone_numbers do |t|
      t.integer :phonable_id
      t.string :phonable_type
      t.string :phone_type
      t.string :number

      t.timestamps
    end
  end
end
