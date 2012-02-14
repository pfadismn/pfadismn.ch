class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.references :address
      t.string :name
      t.text :description
      t.string :coordinates

      t.timestamps
    end
  end
end
