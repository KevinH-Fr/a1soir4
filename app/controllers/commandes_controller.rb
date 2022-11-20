class CommandesController < ApplicationController
  before_action :set_commande, only: %i[ show edit update destroy ]

  def index

  # @commandes = Commande.all
  # @pagy, @commandes = pagy(Commande.order(created_at: :desc), items: 2)

  @pagy, @commandes = pagy(Commande.order(created_at: :desc), items: 2)

  @q = Commande.ransack(params[:q])
  if @q.present?  
    # @commandes = @q.result(distinct: true)
    @pagy, @commandes = pagy(Commande.ransack(params[:q]).result(distinct: true))
  end

  respond_to do |format|
    format.html
    format.pdf do
      render pdf: "Commandes: #{@commandes.count}", # filename
     # template: "hello/print_pdf",
      formats: [:html],
      disposition: :inline,
      layout: 'pdf'
    end
  end

  # @pagy, @commandes = pagy(Commande.ransack(params[:q]).result(distinct: true))
  #  respond_to do |format|
  #    format.html
  #    format.pdf do
  #      render pdf: "commandes: #{@commandes.count}", template: "commandes/index", formats: [:html]
  #    end
  #  end

  end

  def show
    @articles = Article.commande_courante(@commande)
    @paiements = Paiement.commande_courante(@commande)
    @avoirrembs = Avoirremb.commande_courante(@commande)
    @sousarticles = Sousarticle.all

    @client = Client.client_courant(@commande.client_id)

    @commandeId = params[:id]
    session[:commandeId] = @commandeId

    respond_to do |format|
      format.html

    end

  end

  def new 
    @commande = Commande.new 
    @clients = Client.all
    @clientId = params[:clientId]
  end

  def edit
    @commandeId = params[:id]
    @clientId = Commande.find(@commandeId).client_id

    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@commande, partial: "commandes/form", 
          locals: {commande: @commande})
      end
    end
  end

  def create
    @commande = Commande.new(commande_params)

    respond_to do |format|
      if @commande.save
        format.html { redirect_to commande_url(@commande), notice: "Commande was successfully created." }
        format.json { render :show, status: :created, location: @commande }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @commande.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @commande.update(commande_params)

        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@commande, partial: "commandes/commande",
             locals: {commande: @commande})
        end

        format.html { redirect_to commande_url(@commande), notice: "commande was successfully updated." }
        format.json { render :show, status: :ok, location: @commande }
      else

        format.turbo_stream do 
          render turbo_stream: turbo_stream.update(@commande, partial: "commandes/form", 
            locals: {commande: @commande})
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @commande.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @commande.destroy

    respond_to do |format|
      format.html { redirect_to commandes_url, notice: "Commande was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def toggle_commande_client
    @clientId = params[:clientId]
    commande = Commande.create(client_id: @clientId)
    redirect_to commande_path(commande),
        notice: "commande client auto #{@clientId}" 
  end



  def toggle_statut_retire
    commandeId = params[:id]
    commande = Commande.find(commandeId)
    commande.update(statutarticles: "retiré" )
    redirect_to commande_path(commandeId)
  end

  def toggle_statut_non_retire
    commandeId = params[:id]
    commande = Commande.find(commandeId)
    commande.update(statutarticles: "non-retiré" )
    redirect_to commande_path(commandeId)
  end

  def toggle_statut_rendu
    commandeId = params[:id]
    commande = Commande.find(commandeId)
    commande.update(statutarticles: "rendu" )
    redirect_to commande_path(commandeId)
  end






  private
    def set_commande
      @commande = Commande.find(params[:id])
    end

    def commande_params
      params.require(:commande).permit(:nom, :montant, :client_id, :debutloc, :finloc, 
        :dateevenement, :typeevenement, :statutarticles)
    end
end
