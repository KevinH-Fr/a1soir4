class AccueilController < ApplicationController
  layout 'public' # utiliser le layout specific pour la partie site public

    def mariees
      @produits = Produit.categorie_robes_mariees.showed_vitrine
      if Label.last.present?
        @label = Label.last.mariee
      end
    end

    def costumes
      @produits = Produit.categorie_costumes_hommes.showed_vitrine
      if Label.last.present?
        @label = Label.last.homme
      end
    end

    def soirees
      @produits = Produit.categorie_robes_soirees.showed_vitrine
      if Label.last.present?
        @label = Label.last.soiree
      end
    end

    def accessoires
      @produits = Produit.categorie_accessoires.showed_vitrine
      if Label.last.present?
        @label = Label.last.accessoire
      end
    end

    def deguisements
      @produits = Produit.categorie_costumes_deguisements.showed_vitrine
      if Label.last.present?
        @label = Label.last.deguisement
      end
    end

    def index
      if Label.last.present?
        @label = Label.last.principale
      end
    end

    def boutique
      if Texte.last.present?
        @texteContact = Texte.last.contact
        @texteHoraire = Texte.last.horaire
        @texteBoutique = Texte.last.boutique
      end
    end
  
    def contact
      if Texte.last.present?
        @texteContact = Texte.last.contact
        @texteHoraire = Texte.last.horaire
        @texteBoutique = Texte.last.boutique
      end
    end

  end
  