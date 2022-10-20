class Paiement < ApplicationRecord
  belongs_to :commande

  enum typePaiements: ["Prix", "Caution"]

  scope :commande_courante, ->  (commande_courante) { where("commande_id = ?", commande_courante)}
  scope :sum_paiements, -> {sum('montant')}
  scope :compte_paiements, -> {count('montant')}

end