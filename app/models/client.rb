class Client < ApplicationRecord
    has_many :commandes

    validates :nom, presence: true

    scope :client_courant, ->  (client_courant) { where("id = ?", client_courant)}
 
  #  after_create_commit { broadcast_append_to('clients') }

    def full_name
        "#{nom} #{mail} "
    end
end
