class CommandesController < ApplicationController
  before_action :set_commande, only: %i[ show edit update destroy ]

  def index
    @commandes = Commande.all
    @q = Commande.ransack(params[:q])
    @commandes = @q.result(distinct: true)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "commandes: #{@commandes.count}", template: "commandes/index", formats: [:html]
      end
    end

  end

  def show
    @articles = Article.commande_courante(@commande)
    @paiements = Paiement.commande_courante(@commande)
    @sousarticles = Sousarticle.all

    respond_to do |format|
      format.html
      format.png do
        png = Grover.new(url_for()).to_png
        customFilename = "docname"".png"
        send_data(png, disposition: 'inline', filename: customFilename, type: 'application/png', format: 'A4')
      end
      format.pdf do
        pdf = Grover.new(url_for()).to_pdf
        customFilename = "docname"".pdf"
        send_data(pdf, disposition: 'inline', filename: customFilename, type: 'application/pdf', format: 'A4')
      end
    end

  end

  def new
    @commande = Commande.new 
  end

  def edit
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
        format.html { redirect_to commande_url(@commande), notice: "Commande was successfully updated." }
        format.json { render :show, status: :ok, location: @commande }
      else
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

  private
    def set_commande
      @commande = Commande.find(params[:id])
    end

    def commande_params
      params.require(:commande).permit(:nom, :montant, :client_id)
    end
end
