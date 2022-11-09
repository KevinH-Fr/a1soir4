class AddDetailsToCommandes < ActiveRecord::Migration[7.0]
  def change
    add_column :commandes, :debutloc, :date
    add_column :commandes, :finloc, :date
    add_column :commandes, :dateevenement, :date
    add_column :commandes, :statutarticles, :string
  end
end
