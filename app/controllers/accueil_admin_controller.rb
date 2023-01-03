class AccueilAdminController < ApplicationController

    def index
      @clients = Client.all
      @produits = Produit.all
      @commandes = Commande.all
      
      @meetings = Meeting.all
    end

    def stock
      @pagy, @produits = pagy(Produit.order(created_at: :desc), items: 5)
    end 
  
  end
  