class AddClientToMeetings < ActiveRecord::Migration[7.0]
  def change
    add_reference :meetings, :client, null: true, foreign_key: true
  end
end
