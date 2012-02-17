class AddContentImageToEvent < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.has_attached_file :content_image
    end
  end
end
