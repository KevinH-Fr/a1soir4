class CreateSousarticles < ActiveRecord::Migration[7.0]
  def change
    create_table :sousarticles do |t|
      t.references :article, null: false, foreign_key: true
      t.string :nature
      t.text :description
      t.decimal :prix
      t.decimal :caution
      t.string :taille

      t.timestamps
    end
  end
end
