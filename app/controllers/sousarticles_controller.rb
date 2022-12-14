class SousarticlesController < ApplicationController
  before_action :set_sousarticle, only: %i[ show edit update destroy ]

  def index
    @sousarticles = Sousarticle.all
  end

  def show
  end

  def new
    @sousarticle = Sousarticle.new sousarticle_params

    @articleId = params[:articleId]
    session[:articleId] = params[:articleId]

    @natures = Modelsousarticle.distinct.pluck(:nature)

  end

  def edit
    @articleId = params[:articleId]
    session[:articleId] = params[:articleId]
    @natures = Modelsousarticle.distinct.pluck(:nature)

    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@sousarticle, partial: "sousarticles/form", 
          locals: {sousarticle: @sousarticle})
      end
    end

  end

  def create
    @articleId = params[:articleId]
    @sousarticle = Sousarticle.new(sousarticle_params)
    @commandeId = Article.find(@sousarticle.article_id).commande_id
    @produitId = Article.find(@sousarticle.article_id).produit_id

    respond_to do |format|
      if @sousarticle.save
        format.html { redirect_to edit_article_path(@sousarticle.article_id, commandeId: @commandeId, produitId:  @produitId), 
             notice: "Sousarticle was successfully created." }
        format.json { render :show, status: :created, location: @sousarticle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sousarticle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @commandeId = Article.find(@sousarticle.article_id).commande_id
    @produitId = Article.find(@sousarticle.article_id).produit_id
    @natures = Modelsousarticle.distinct.pluck(:nature)
    @articleId = params[:articleId]

    respond_to do |format|
      if @sousarticle.update(sousarticle_params)

        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@sousarticle, partial: "sousarticles/sousarticle",
             locals: {sousarticle: @sousarticle})
        end

        format.html { redirect_to edit_article_path(@sousarticle.article_id, commandeId: @commandeId, produitId:  @produitId), 
             notice: "Sousarticle was successfully updated." }
        format.json { render :show, status: :ok, location: @sousarticle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sousarticle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @commandeId = Article.find(@sousarticle.article_id).commande_id
    @produitId = Article.find(@sousarticle.article_id).produit_id

    @sousarticle.destroy

    respond_to do |format|
      format.html { redirect_to edit_article_path(@sousarticle.article_id, commandeId: @commandeId, produitId:  @produitId), notice: "Sousarticle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def toggle_sousarticleauto

    @articleId = params[:id]
    @commandeId = params[:commandeId]
    @produitId = params[:produitId]

    prixChemise = Modelsousarticle.where(nature: "chemise").first.prix if Modelsousarticle.where(nature: "chemise").first.present?
    prixVeste = Modelsousarticle.where(nature: "veste").first.prix if Modelsousarticle.where(nature: "veste").first.present?
    prixPantalon = Modelsousarticle.where(nature: "pantalon").first.prix if Modelsousarticle.where(nature: "pantalon").first.present?
    prixCeinture = Modelsousarticle.where(nature: "ceinture").first.prix if Modelsousarticle.where(nature: "ceinture").first.present?
    prixChaussures = Modelsousarticle.where(nature: "chaussures").first.prix if Modelsousarticle.where(nature: "chaussures").first.present?
    prixChemise = Modelsousarticle.where(nature: "chemise").first.prix if Modelsousarticle.where(nature: "chemise").first.present?
    prixGilet = Modelsousarticle.where(nature: "gilet").first.prix if Modelsousarticle.where(nature: "gilet").first.present?
    prixRetouches = Modelsousarticle.where(nature: "retouches").first.prix if Modelsousarticle.where(nature: "retouches").first.present?
    prixAutre = Modelsousarticle.where(nature: "autre").first.prix if Modelsousarticle.where(nature: "autre").first.present?

    valCategorie = Produit.find(@produitId).categorie

    if valCategorie == "Costumes hommes"
      sousarticle = Sousarticle.create(article_id: @articleId, nature: "veste", prix_sousarticle: prixVeste)
      sousarticle = Sousarticle.create(article_id: @articleId, nature: "pantalon", prix_sousarticle: prixPantalon)

    else
      sousarticle = Sousarticle.create(article_id: @articleId, nature: "retouches", prix_sousarticle: prixRetouches)
 
    end 

      redirect_to edit_article_path(@articleId, produitId: @produitId, 
        commandeId: @commandeId, articleId: @articleId),
        notice: "test sous article auto  #{@articleId}" 
  end

  private

    def set_sousarticle
      @sousarticle = Sousarticle.find(params[:id])
    end

    def sousarticle_params
      params.fetch(:sousarticle, {}).permit(:article_id, :nature, :description, :prix_sousarticle, :caution_sousarticle, :taille)
    end
end
