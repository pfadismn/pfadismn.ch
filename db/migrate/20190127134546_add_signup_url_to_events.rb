class AddSignupUrlToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :midata_url, :string, null: true
  end
end
