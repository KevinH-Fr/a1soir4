class AddDetailsToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :prenom, :string
    add_column :clients, :typepropart, :string
    add_column :clients, :intitule, :string
    add_column :clients, :tel2, :string
    add_column :clients, :mail2, :string
    add_column :clients, :adresse, :string
    add_column :clients, :ville, :string
    add_column :clients, :cp, :string
    add_column :clients, :pays, :string
  end
end
