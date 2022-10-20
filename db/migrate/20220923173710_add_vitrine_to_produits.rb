class AddVitrineToProduits < ActiveRecord::Migration[7.0]
  def change
    add_column :produits, :vitrine, :boolean
  end
end
