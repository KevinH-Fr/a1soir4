class AddClientToCommandes < ActiveRecord::Migration[7.0]
  def change
    add_reference :commandes, :client, null: true, foreign_key: true
  end
end
