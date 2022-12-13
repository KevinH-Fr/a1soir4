class ApplicationController < ActionController::Base
    include Pagy::Backend

    def after_sign_in_path_for(resource)
        accueil_admin_path() # rediriger apres login
    end

    before_action :set_q

    def set_q
        @q = Produit.ransack(params[:q]) 
        @produits = @q.result(distinct: true)
    end

end
