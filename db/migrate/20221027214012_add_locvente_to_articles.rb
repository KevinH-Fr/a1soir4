class AddLocventeToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :locvente, :string
  end
end
