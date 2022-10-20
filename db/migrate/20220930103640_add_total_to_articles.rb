class AddTotalToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :total, :decimal
  end
end
