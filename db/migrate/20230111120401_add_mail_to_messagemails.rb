class AddMailToMessagemails < ActiveRecord::Migration[7.0]
  def change
    add_column :messagemails, :mail, :string
  end
end
