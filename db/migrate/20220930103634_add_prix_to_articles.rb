class AddPrixToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :prix, :decimal
  end
end
