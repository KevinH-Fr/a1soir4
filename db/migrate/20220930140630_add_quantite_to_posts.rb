class AddQuantiteToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :quantite, :integer
  end
end
