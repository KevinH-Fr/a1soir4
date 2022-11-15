class Paiement < ApplicationRecord
  belongs_to :commande, :optional => true

  enum typePaiements: ["Prix", "Caution"]

  scope :commande_courante, ->  (commande_courante) { where("commande_id = ?", commande_courante)}
  
  scope :prix_only, -> { where("typepaiement = ?", "Prix")}
  scope :caution_only, -> { where("typepaiement = ?", "Caution")}

  scope :sum_paiements, -> {sum('montant')}

  scope :sum_paiements, -> {sum('montant')}
  scope :compte_paiements, -> {count('montant')}


  def format_date
    datetime = created_at.to_date
    created_at.strftime("%d/%m/%y")
  end 

  def texte_record
    datetime = created_at.to_date
     "#{typepaiement}" " d'un montant de " "#{montant}" " € reçu le " "#{created_at.strftime("%d/%m/%y")}"
  end 

end