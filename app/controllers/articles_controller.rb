class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  def index
    @articles = Article.all
  end

  def show
    @sousarticles = Sousarticle.article_courant(@article)
  end

  def new
    @article = Article.new article_params

    @commandeId = params[:commandeId]
    session[:commandeId] = params[:commandeId]

    @produitId = params[:produitId]
    session[:produitId] = params[:produitId]

    @sousarticles = Sousarticle.article_courant(@article)

    @typelocvente = ["location", "vente"]
    
    
    @quantite = 1
    
    if @produitId.present?
     @valPrix = Produit.find(@produitId).prix
     @valCaution = 10
    else
      @valPrix = 0
    end 
    
    if @quantite.present? && @valPrix.present? 
      @valTotal =  @quantite * @valPrix 
    else
      @valTotal = 0  
    end

    categorieVal = params[:categorieVal]
    couleurVal = params[:couleurVal]

    if categorieVal.present?
      @produits = Produit.categorie_selected(categorieVal)
      @couleurs = Produit.categorie_selected(categorieVal).distinct.pluck(:couleur)
        if couleurVal.present?
          @produits = Produit.categorie_selected(categorieVal).couleur_selected(couleurVal)
        end
    else
      @produits = Produit.all 
    end
    @categories = Produit.distinct.pluck(:categorie)

    qVal = params[:q]
    if qVal.present?
      @q = Produit.ransack(params[:q])
      @produits = @q.result(distinct: true)
    end 

  
  end

  def edit

    @commandeId = params[:commandeId]
    @produitId = params[:produitId]
    @natures = Modelsousarticle.distinct.pluck(:nature)
    @typelocvente = ["location", "vente"]
    
    @articleId = 5

    @sousarticles = Sousarticle.article_courant(@article)

    @quantite = Article.find(@article.id).quantite
    @valPrix = Article.find(@article.id).prix
  

    if @quantite.present? && @valPrix.present? 
      @valTotal =  @quantite * @valPrix 
    else
      @valTotal = 0  
    end
    
  end

  def create
    @article = Article.new(article_params)
    @categories = Produit.distinct.pluck(:categorie)
    @sousarticles = Sousarticle.article_courant(@article)

    @produitId = @article.produit_id
    @commandeId = @article.commande_id

    respond_to do |format|
      if @article.save
        format.html { redirect_to edit_article_path(@article, commandeId: @commandeId, produitId: @produitId, articleId: @article),
                      notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    @produitId = @article.produit_id
    @commandeId = @article.commande_id

    respond_to do |format|
      if @article.update(article_params)
        format.html  { redirect_to commande_path(@commandeId),
          notice: "L'article a bien été créé" }
        format.json { render :show, status: :ok, location: @article }
        @article.save
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @commandeId = @article.commande_id
    
    @article.destroy

    respond_to do |format|
      format.html { redirect_to commande_url( @commandeId ), notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def toggle_selectProduit
    @commandeId = session[:commandeId]
    @produitId =  session[:produitId]

    redirect_to new_article_path(commandeId: @commandeId, produitId: @produitId),
    notice: "test notif selection produit n°#{@produitId} |"  "commande n°#{@commandeId}"

  end

  private
     def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.fetch(:article, {}).permit(:quantite, :commande_id, :produit_id, :prix, :caution, :total, :locvente)
    end
end
