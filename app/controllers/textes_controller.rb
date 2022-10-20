class TextesController < ApplicationController
  before_action :set_texte, only: %i[ show edit update destroy ]

  def index
    @textes = Texte.all.with_rich_text_content
  end

  def show
  end

  def new
    @texte = Texte.new
  end

  def edit
  end

  def create
    @texte = Texte.new(texte_params)

    respond_to do |format|
      if @texte.save
        format.html { redirect_to texte_url(@texte), notice: "Texte was successfully created." }
        format.json { render :show, status: :created, location: @texte }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @texte.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @texte.update(texte_params)
        format.html { redirect_to texte_url(@texte), notice: "Texte was successfully updated." }
        format.json { render :show, status: :ok, location: @texte }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @texte.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @texte.destroy

    respond_to do |format|
      format.html { redirect_to textes_url, notice: "Texte was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
     def set_texte
      @texte = Texte.find(params[:id])
    end

    def texte_params
      params.require(:texte).permit(:titre, :content, :contact, :horaire, :boutique)
    end
end
