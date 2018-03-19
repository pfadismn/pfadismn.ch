class AddContentImageToEvent < ActiveRecord::Migration[4.2]
  def change
    change_table :events do |t|
      t.has_attached_file :content_image
    end
  end
end
