class AddCouleurToProduits < ActiveRecord::Migration[7.0]
  def change
    add_column :produits, :couleur, :string
  end
end
