class CreateMembers < ActiveRecord::Migration[4.2]
  def change
    create_table :members do |t|
      t.references :organisational_unit
      t.string :first_name
      t.string :last_name
      t.string :scout_name
      t.string :email
      t.string :nationality
      t.text :remarks
      t.date :birthdate
      t.integer :gender
      t.integer :functions_mask
      t.boolean :vegetarian
      t.date :member_since
      t.text :education

      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at

      t.timestamps
    end
    add_index :members, :organisational_unit_id
  end
end
