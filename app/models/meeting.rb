class Meeting < ApplicationRecord

    scope :commande_courante, ->  (commande_courante) { where("commande_id = ?", commande_courante)}

end
