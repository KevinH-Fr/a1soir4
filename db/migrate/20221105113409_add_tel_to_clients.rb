class AddTelToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :tel, :string
  end
end
