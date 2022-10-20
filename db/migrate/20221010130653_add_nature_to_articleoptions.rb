class AddNatureToArticleoptions < ActiveRecord::Migration[7.0]
  def change
    add_reference :articleoptions, :article, null: true, foreign_key: true
  end
end
