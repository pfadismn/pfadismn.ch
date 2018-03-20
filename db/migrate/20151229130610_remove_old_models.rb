class RemoveOldModels < ActiveRecord::Migration[4.2]
  def up
    drop_table :alumni_addresses
    drop_table :meeting_protocols
  end

  def down
  end
end
