class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.integer :quantite
      t.references :commande, null: true, foreign_key: true
      t.references :produit, null: true, foreign_key: true

      t.timestamps
    end
  end
end
