class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :nom
      t.string :mail
      t.text :commentaires

      t.timestamps
    end
  end
end
