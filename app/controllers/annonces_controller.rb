class AnnoncesController < ApplicationController
    def index
        @annonces = Annonce.all
    end
end