class RemoveCommandeFromArticleoptions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :articleoptions, :commande, null: false, foreign_key: true
  end
end
