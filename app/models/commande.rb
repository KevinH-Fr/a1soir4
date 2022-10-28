class Commande < ApplicationRecord
    belongs_to :client

    scope :client_courant, ->  (client_courant) { where("client_id = ?", client_courant)}

    def full_name
      "n°#{id} | #{nom}"
    end

    def format_date
      datetime = created_at.to_date
      created_at.strftime("%d/%m/%y")
    end 

    def texte_record
      "n°#{id} | #{type_locvente} | #{nom} | #{created_at.strftime("%d/%m/%y")}" 
    end

    def type_locvente
      arr = Article.commande_courante(id).distinct.pluck(:locvente)
      if (arr - ["location"]).empty?
        "location"
      else
        if (arr - ["vente"]).empty?
          "vente"
        else
          "location & vente"
        end
      end
    end

end
