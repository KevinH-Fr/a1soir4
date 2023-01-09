class Meeting < ApplicationRecord

    scope :commande_courante, ->  (commande_courante) { where("commande_id = ?", commande_courante)}
    scope :client_courant, ->  (client_courant) { where("client_id = ?", client_courant)}


end
