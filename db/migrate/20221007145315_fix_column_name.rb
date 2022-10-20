class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :paiements, :type, :typepaiement
  end
end
