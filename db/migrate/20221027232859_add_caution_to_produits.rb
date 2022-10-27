class AddCautionToProduits < ActiveRecord::Migration[7.0]
  def change
    add_column :produits, :caution, :decimal
  end
end
