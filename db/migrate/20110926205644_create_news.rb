class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.references :creator
      t.string :title
      t.text :body
      t.datetime :published_at

      t.timestamps
    end
    add_index :news, :creator_id
  end
end