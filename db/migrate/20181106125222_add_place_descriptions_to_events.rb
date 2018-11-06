class AddPlaceDescriptionsToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :start_place_description, :string
    add_column :events, :end_place_description, :string
  end
end
