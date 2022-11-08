class AddDetailsToProduits < ActiveRecord::Migration[7.0]
  def change
    add_column :produits, :handle, :string
    add_column :produits, :reffrs, :string
    add_column :produits, :taille, :string
  end
end
