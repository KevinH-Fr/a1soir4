class Client < ApplicationRecord
    has_many :commandes

    validates :nom, presence: true

    enum typeproparts: ["Particulier", "Professionnel"]
    enum intitules: ["Madame", "Monsieur", "Société", "Entreprise"]

    scope :client_courant, ->  (client_courant) { where("id = ?", client_courant)}

    def full_name
        "#{prenom} #{nom}"
    end

    def text_record
        "#{intitule} #{nom} #{tel} #{mail} "
    end

    def intitule_nom
        "#{intitule} #{nom}"
    end
end
