class ProduitsController < ApplicationController
  before_action :set_produit, only: %i[ show edit update destroy ]

  def index

    search_params = params.permit(:format, :page, 
    q:[:nom_or_categorie_or_couleur_cont])
    @q = Produit.ransack(search_params[:q])
    produits = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @produits = pagy_countless(produits, items: 2)
  

  end

  def show

    @produitId = params[:id]
    session[:produitId] = @produitId

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "etiquette #{@produitId}", # filename
          :margin => {
            :top => 5,
            :bottom => 5
          },
          
          :template => "produits/etiquette",
            footer:  { 
              html: { 
                template:'shared/doc_footer',  
                formats: [:html],      
                layout:  'pdf',  
              },
            },
          
            formats: [:html],
            layout: 'pdf'
      end
    end

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

    flash.now[:notice] = "le produit #{@produit.nom} a été supprimé"

    respond_to do |format|

      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@produit),
          turbo_stream.update("produit_counter", Produit.count),
          turbo_stream.update("flash", partial: "layouts/flash")
        ]
      end

    #  format.html { redirect_to produits_url, notice: "Produit was successfully destroyed." }
    #  format.json { head :no_content }
    end
  end

  private
  
    def set_produit
      @produit = Produit.find(params[:id])
    end

    def produit_params
      params.require(:produit).permit(:nom, :prix, :caution, :description, :categorie, 
          :couleur, :image1, :vitrine, :eshop, :handle, :reffrs, :taille, :quantite)
    end
end
