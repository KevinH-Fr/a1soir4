class Produit < ApplicationRecord

    has_one_attached :image1
    has_one_attached :qr_code
    has_one_attached :barcode

    after_create :generate_qr

    def generate_qr
        GenerateQr.call(self)
        GenerateBarcode.call(self)
    end
    
    enum categories: ["Robes de soirées", "Robes de mariées", "Costumes hommes", "Accessoires", "Costumes et déguisements"]
    enum couleurs: ["Bleu", "Blanc", "Rouge"]
    enum tailles: ["S", "M", "L"]

    scope :showed_vitrine, -> { where("vitrine = ?", true) }
    scope :showed_eshop, -> { where("eshop = ?", true) }
    
    scope :compte_produits, -> {sum('quantite')}

    scope :categorie_robes_soirees, -> { where("categorie = ?", "Robes de soirées") } # categorie 1
    scope :categorie_robes_mariees, -> { where("categorie = ?", "Robes de mariées") }
    scope :categorie_costumes_hommes, -> { where("categorie = ?", "Costumes hommes") }
    scope :categorie_accessoires, -> { where("categorie = ?", "Accessoires") }
    scope :categorie_costumes_deguisements, -> { where("categorie = ?", "Costumes et déguisements") }

    scope :categorie_selected, ->  (categorieVal) { where("categorie = ?", categorieVal)}
    scope :couleur_selected, ->  (couleurVal) { where("couleur = ?", couleurVal)}
    scope :taille_selected, ->  (tailleVal) { where("taille = ?", tailleVal)}


    def full_name
        "n°#{id} | #{nom} "
    end

    def full_details
        {
            id: id,
            nom: nom,
            description: description,
            image: image1
        }
    end

    def default_image
        if self.image1.filename.to_s.length > 0 
            image1
        else
            "no_photo.png"
        end
    end

    def statut_vitrine
        if self.vitrine == true
            "vrai_icon.png"
        else
            "false_icon.png"
        end 
    end


#  def self.search(search)
#      if search
#          produits = Produit.all
#          produits = produits.where(categorie: search[:":categorie"][","])#
#           return produits
#       else
#           Produit.all
#       end
#   end

end



