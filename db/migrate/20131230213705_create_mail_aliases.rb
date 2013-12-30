class CreateMailAliases < ActiveRecord::Migration
  def change
    create_table :mail_aliases do |t|
      t.string :email
      t.string :alias

      t.timestamps
    end
  end
end
