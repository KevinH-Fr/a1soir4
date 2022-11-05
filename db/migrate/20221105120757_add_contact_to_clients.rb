class AddContactToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :contact, :string
  end
end
