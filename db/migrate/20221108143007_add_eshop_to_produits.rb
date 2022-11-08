class AddEshopToProduits < ActiveRecord::Migration[7.0]
  def change
    add_column :produits, :eshop, :boolean
  end
end
