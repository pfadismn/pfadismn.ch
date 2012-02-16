class CreateOrganisationalUnits < ActiveRecord::Migration
  def change
    create_table :organisational_units do |t|
      t.string :name
      t.string :motto
      t.string :caption
      
      t.string :responsible_function
      
      # Nested set Attributes
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
    add_index :organisational_units, :parent_id
  end
end
