class CreateCommandes < ActiveRecord::Migration[7.0]
  def change
    create_table :commandes do |t|
      t.string :nom
      t.decimal :montant

      t.timestamps
    end
  end
end
