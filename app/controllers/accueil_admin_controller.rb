class AccueilAdminController < ApplicationController

    def index
      @clients = Client.all
      @produits = Produit.all
      @commandes = Commande.all

      @q = Client.ransack(params[:q])
      @clients = @q.result(distinct: true)
    end

    def stock
      @pagy, @produits = pagy(Produit.order(created_at: :desc), items: 5)
    end 
  
  end
  