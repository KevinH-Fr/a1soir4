class AddCommentairesdocToCommandes < ActiveRecord::Migration[7.0]
  def change
    add_column :commandes, :commentairesdoc, :text
  end
end
