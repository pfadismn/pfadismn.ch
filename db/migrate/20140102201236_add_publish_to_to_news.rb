class AddPublishToToNews < ActiveRecord::Migration
  def change
    add_column :news, :publish_to_mask, :integer, default: 1
  end
end
