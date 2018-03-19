class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.references :member
      t.string :email,                  :null => false
      t.string :crypted_password,       :null => false
      t.string :password_salt,          :null => false
      t.string :persistence_token,      :null => false
      t.string :perishable_token,    :null => false
      t.integer :roles_mask
      t.timestamps
    end

    add_index :users, :email
    add_index :users, :persistence_token
  end
end
