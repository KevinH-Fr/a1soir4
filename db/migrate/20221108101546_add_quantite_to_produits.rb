class AddQuantiteToProduits < ActiveRecord::Migration[7.0]
  def change
    add_column :produits, :quantite, :integer
  end
end
