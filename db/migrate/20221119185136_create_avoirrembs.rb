class CreateAvoirrembs < ActiveRecord::Migration[7.0]
  def change
    create_table :avoirrembs do |t|
      t.string :typeavoirremb
      t.decimal :montant
      t.string :natureavoirremb
      t.references :commande, null: false, foreign_key: true

      t.timestamps
    end
  end
end
