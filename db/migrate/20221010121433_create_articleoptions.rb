class CreateArticleoptions < ActiveRecord::Migration[7.0]
  def change
    create_table :articleoptions do |t|
      t.references :commande, null: true, foreign_key: true
      t.string :nature
      t.text :description
      t.decimal :prix
      t.decimal :caution
      t.string :taille

      t.timestamps
    end
  end
end
