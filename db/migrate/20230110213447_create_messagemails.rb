class CreateMessagemails < ActiveRecord::Migration[7.0]
  def change
    create_table :messagemails do |t|
      t.string :titre
      t.text :body
      t.references :commande, null: true, foreign_key: true
      t.references :client, null: true, foreign_key: true

      t.timestamps
    end
  end
end
