class AddTextefasimpledocToCommandes < ActiveRecord::Migration[7.0]
  def change
    add_column :commandes, :textefasimpledoc, :text
  end
end
