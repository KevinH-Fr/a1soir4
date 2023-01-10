class Messagemail < ApplicationRecord
  belongs_to :commande, :optional => true
  belongs_to :client, :optional => true
end
