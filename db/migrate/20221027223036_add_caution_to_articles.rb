class AddCautionToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :caution, :decimal
  end
end
