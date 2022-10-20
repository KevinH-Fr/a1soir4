class PaiementsController < ApplicationController
  before_action :set_paiement, only: %i[ show edit update destroy ]

  def index
    @paiements = Paiement.all
  end

  def show
  end

  def new
    @paiement = Paiement.new paiement_params

    @commandeId = params[:commandeId]
    session[:commandeId] = params[:commandeId]
  end

  def edit
    @commandeId = params[:commandeId]
  end

  def create
    @paiement = Paiement.new(paiement_params)

    respond_to do |format|
      if @paiement.save
        format.html { redirect_to commande_url(@paiement.commande_id), notice: "Paiement was successfully created." }
        format.json { render :show, status: :created, location: @paiement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @paiement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @paiement.update(paiement_params)
        format.html { redirect_to commande_url(@paiement.commande_id), notice: "Paiement was successfully updated." }
        format.json { render :show, status: :ok, location: @paiement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @paiement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @paiement.destroy

    respond_to do |format|
      format.html { redirect_to commande_url(params[:id]), notice: "Paiement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
     def set_paiement
      @paiement = Paiement.find(params[:id])
    end

    def paiement_params
      params.fetch(:paiement, {}).permit(:typepaiement, :montant, :commande_id)
    end
end
