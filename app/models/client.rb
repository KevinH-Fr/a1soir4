class Client < ApplicationRecord
    has_many :commandes

    validates :nom, presence: true

    enum typeproparts: ["Particulier", "Professionnel"]
    enum intitules: ["Madame", "Monsieur", "Société", "Entreprise"]

    scope :client_courant, ->  (client_courant) { where("id = ?", client_courant)}
 
    def full_name
        "#{nom} #{mail} "
    end
end
