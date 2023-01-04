class CommandesController < ApplicationController
  before_action :set_commande, only: %i[ show edit update destroy ]

  def index

    search_params = params.permit(:format, :page, 
    q:[:nom_or_typeevenement_or_client_prenom_or_client_nom_or_profile_prenom_cont])
    @q = Commande.includes(:client, :profile).ransack(search_params[:q])
    commandes = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @commandes = pagy_countless(commandes, items: 2)

  end

  def show
    
    @articles = Article.commande_courante(@commande)
    @paiements = Paiement.commande_courante(@commande)
    @avoirrembs = Avoirremb.commande_courante(@commande)
    @sousarticles = Sousarticle.all

    @typedocs = ["bon de commande", "facture", "facture simple"]
    @client = Client.client_courant(@commande.client_id)

    @commandeId = params[:id]
    session[:commandeId] = @commandeId

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

        # CommandeMailer.with(user: current_user, commande: @commande).commande_created.deliver_later
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
          render turbo_stream: 
          turbo_stream.update(@commande, partial: "commandes/commande",
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
    clientId = params[:id]
    @commande = Commande.create(client_id: clientId, profile_id: Profile.first.id) 
    redirect_to commande_path(@commande),
       notice: "commande client auto #{clientId}" 
    
  end

  def toggle_statut_retire
    commandeId = params[:id]
    commande = Commande.find(commandeId)
    commande.update(statutarticles: "retiré" )
    redirect_to commande_path(commandeId),
      notice: "commande retirée par client" 
  end

  def toggle_statut_non_retire
    commandeId = params[:id]
    commande = Commande.find(commandeId)
    commande.update(statutarticles: "non-retiré" )
    redirect_to commande_path(commandeId),
      notice: "commande non-retirée par client" 
  end

  def toggle_statut_rendu
    commandeId = params[:id]
    commande = Commande.find(commandeId)
    commande.update(statutarticles: "rendu" )
    redirect_to commande_path(commandeId),
      notice: "commande rendue par client" 
  end

  def editer_pdf

    @commande = Commande.find(params[:id])
    typedoc = params[:typedoc]

    pdf = WickedPdf.new.pdf_from_html_file(
      render_to_string('commandes/bonCommande', layout: 'pdf'),
        header: {
          content: render_to_string(
            'shared/doc_entete',
            layout: 'pdf'
          )
        },
        footer: {
          content: render_to_string(
            'shared/doc_footer',
            layout: 'pdf'
          )
        }
    )

    # Envoi du PDF en tant que fichier à télécharger
    send_data pdf,
      filename: "#{typedoc}_" "#{@commande.id}",
      type: 'application/pdf',
      disposition: 'inline'

  end 

  def send_commande_mail()

    commande = Commande.find(params[:id])
    typedoc = params[:typedoc]

    CommandeMailer.commande_created(commande, typedoc).deliver_now
      flash[:notice] = "le mail a bien été envoyé"
      redirect_to commande_path(commande, typedoc: typedoc )

  end 
  

  private
    def set_commande
      @commande = Commande.find(params[:id])
    end

    def commande_params
      params.require(:commande).permit(:nom, :montant, :client_id, :debutloc, :finloc, 
        :dateevenement, :typeevenement, :statutarticles, :profile_id, :commentairesdoc, :textefasimpledoc)
    end
end
