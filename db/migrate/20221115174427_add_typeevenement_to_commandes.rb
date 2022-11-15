class AddTypeevenementToCommandes < ActiveRecord::Migration[7.0]
  def change
    add_column :commandes, :Typeevenement, :string
  end
end
