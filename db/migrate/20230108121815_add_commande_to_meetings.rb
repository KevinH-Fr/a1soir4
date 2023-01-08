class AddCommandeToMeetings < ActiveRecord::Migration[7.0]
  def change
    add_reference :meetings, :commande, null: true, foreign_key: true
  end
end
