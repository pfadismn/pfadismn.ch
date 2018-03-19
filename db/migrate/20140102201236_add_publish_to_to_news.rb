class AddPublishToToNews < ActiveRecord::Migration[4.2]
  def change
    add_column :news, :publish_to_mask, :integer, default: 1
  end
end
