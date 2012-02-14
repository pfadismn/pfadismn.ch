class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :organisational_unit
      t.references :creator
      t.references :start_place
      t.references :end_place
      t.datetime :start_time
      t.datetime :end_time
      t.string :name
      t.text :description
      t.text :take_along
      t.text :content
      t.datetime :published_at

      t.timestamps
    end
    add_index :events, :organisational_unit_id
    add_index :events, :creator_id
    add_index :events, :start_place_id
    add_index :events, :end_place_id
  end
end
