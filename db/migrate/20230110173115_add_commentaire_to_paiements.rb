class AddCommentaireToPaiements < ActiveRecord::Migration[7.0]
  def change
    add_column :paiements, :commentaire, :text
  end
end
