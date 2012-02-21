class AddActiveToOrganisationalUnit < ActiveRecord::Migration
  def change
    change_table :organisational_units do |t|
      t.boolean :active, default: true
    end
  end
end
