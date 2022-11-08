class ProduitsController < ApplicationController
  before_action :set_produit, only: %i[ show edit update destroy ]

  def index
    categorieVal = params[:categorieVal]
    if categorieVal.present?
      @produits = Produit.categorie_selected(categorieVal)
    else
      @produits = Produit.all 
    end
    
    @categories = Produit.distinct.pluck(:categorie)

    @pagy, @produits = pagy(Produit.order(created_at: :desc), items: 5)

    qVal = params[:q]
    if qVal.present?
      @q = Produit.ransack(params[:q])
      @produits = @q.result(distinct: true)
    end 

  end

  def show
  end

  def new
    @produit = Produit.new
  end

  def edit
    @handle = @produit.nom.parameterize
    
    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@produit, partial: "produits/form", 
          locals: {produit: @produit})
      end
    end
  end

  def create
    @produit = Produit.new(produit_params)

    respond_to do |format|
      if @produit.save

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("produits", partial: "produits/produit",
            locals: {produit: @produit }),
          ]
        end

        format.html { redirect_to produit_url(@produit), notice: "Produit was successfully created." }
        format.json { render :show, status: :created, location: @produit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @produit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @produit.update(produit_params)

        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@produit, partial: "produits/produit", locals: {produit: @produit})
        end

        format.html { redirect_to produit_url(@produit), notice: "Produit was successfully updated." }
        format.json { render :show, status: :ok, location: @produit }
      else

        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@produit, partial: "produits/form", locals: {produit: @produit})
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @produit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @produit.destroy

    respond_to do |format|
      format.html { redirect_to produits_url, notice: "Produit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
    def set_produit
      @produit = Produit.find(params[:id])
    end

    def produit_params
      params.require(:produit).permit(:nom, :prix, :caution, :description, :categorie, :couleur, :image1, :vitrine, :handle, :reffrs, :taille)
    end
end
