class Avoirremb < ApplicationRecord
  belongs_to :commande

  enum typeAvoirrembs: ["Avoir", "Remboursement"]
  enum natureAvoirrembs: ["CB", "Espèces", "Virement", "Chèque"]

  scope :commande_courante, ->  (commande_courante) { where("commande_id = ?", commande_courante)}
  
end
