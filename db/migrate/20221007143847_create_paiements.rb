class CreatePaiements < ActiveRecord::Migration[7.0]
  def change
    create_table :paiements do |t|
      t.string :type
      t.decimal :montant
      t.references :commande, null: false, foreign_key: true

      t.timestamps
    end
  end
end
