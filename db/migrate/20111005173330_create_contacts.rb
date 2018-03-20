class CreateContacts < ActiveRecord::Migration[4.2]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.integer :relation_mask
      t.text :remarks

      t.timestamps
    end

    create_table :member_contacts, :id => false do |t|
      t.integer :contact_id
      t.integer :member_id
      t.string :relation
    end
  end
end
