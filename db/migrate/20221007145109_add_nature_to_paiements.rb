class AddNatureToPaiements < ActiveRecord::Migration[7.0]
  def change
    add_column :paiements, :nature, :string
  end
end
