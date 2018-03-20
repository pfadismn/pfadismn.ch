class CreatePhotoAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :photo_albums do |t|
      t.integer :year
      t.string :title
      t.string :description
      t.string :place
      t.string :flickr_id
      t.string :flickr_url

      t.timestamps
    end
  end
end
