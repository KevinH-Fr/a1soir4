class AddProfileToCommandes < ActiveRecord::Migration[7.0]
  def change
    add_reference :commandes, :profile, null: true, foreign_key: true
  end
end
