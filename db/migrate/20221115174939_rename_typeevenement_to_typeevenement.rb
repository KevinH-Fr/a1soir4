class RenameTypeevenementToTypeevenement < ActiveRecord::Migration[7.0]
  def change
    rename_column :commandes, :Typeevenement, :typeevenement
  end
end
