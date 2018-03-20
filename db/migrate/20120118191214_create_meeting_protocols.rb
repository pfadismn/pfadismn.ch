class CreateMeetingProtocols < ActiveRecord::Migration[4.2]
  def change
    create_table :meeting_protocols do |t|
      t.references :organisational_unit
      t.string :title
      t.text :body

      t.timestamps
    end

    create_table :meeting_protocols_members, id: false do |t|
      t.integer :participant_id
      t.integer :meeting_protocol_id
    end

    add_index :meeting_protocols_members, :participant_id
    add_index :meeting_protocols_members, :meeting_protocol_id
    add_index :meeting_protocols, :organisational_unit_id
  end
end
