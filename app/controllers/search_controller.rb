class SearchController < ApplicationController
  def index
    @q = Produit.ransack(params[:q])
    @produits = @q.result(distinct: true)
  end
end

