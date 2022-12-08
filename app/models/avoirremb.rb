class Avoirremb < ApplicationRecord
  belongs_to :commande

  enum typeAvoirrembs: ["Avoir", "Remboursement"]
  enum natureAvoirrembs: ["CB", "Espèces", "Virement", "Chèque"]

  scope :commande_courante, ->  (commande_courante) { where("commande_id = ?", commande_courante)}
  scope :avoir_only, -> { where("typeavoirremb = ?", "Avoir")}
  scope :remboursement_only, -> { where("typeavoirremb = ?", "Remboursement")}
  scope :sum_avoirrembs, -> {sum('montant')}
  scope :compte_avoirrembs, -> {count('montant')}

end
