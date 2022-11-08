class Article < ApplicationRecord
  belongs_to :commande
  belongs_to :produit

  has_many :sousarticles, :dependent => :delete_all 

  enum typelocventes: ["Location", "Vente"]
  
 # enum quantite: {1 => 1, 2 => 2, 3 => 3}

  scope :commande_courante, ->  (commande_courante) { where("commande_id = ?", commande_courante)}
  scope :sum_articles, -> {sum('total')}
  scope :compte_articles, -> {sum('quantite')}

  scope :sum_sousarticles, -> {joins(:sousarticles).sum('prix_sousarticle')}

  scope :articlesLoues, -> { where("Locvente = ?", "location")}
  scope :articlesVendus, -> { where("Locvente = ?", "vente")}





  after_initialize :set_defaults

  def set_defaults
    self.quantite ||= 1
    self.total ||= 50
  end

end
