class ModelsousarticlesController < ApplicationController
  before_action :set_modelsousarticle, only: %i[ show edit update destroy ]

  def index
    @modelsousarticles = Modelsousarticle.all
  end

  def show
  end

  def new
    @modelsousarticle = Modelsousarticle.new
  end

  def edit
  end

  def create
    @modelsousarticle = Modelsousarticle.new(modelsousarticle_params)

    respond_to do |format|
      if @modelsousarticle.save
        format.html { redirect_to modelsousarticle_url(@modelsousarticle), notice: "Modelsousarticle was successfully created." }
        format.json { render :show, status: :created, location: @modelsousarticle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @modelsousarticle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @modelsousarticle.update(modelsousarticle_params)
        format.html { redirect_to modelsousarticle_url(@modelsousarticle), notice: "Modelsousarticle was successfully updated." }
        format.json { render :show, status: :ok, location: @modelsousarticle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @modelsousarticle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @modelsousarticle.destroy

    respond_to do |format|
      format.html { redirect_to modelsousarticles_url, notice: "Modelsousarticle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_modelsousarticle
      @modelsousarticle = Modelsousarticle.find(params[:id])
    end

    def modelsousarticle_params
      params.require(:modelsousarticle).permit(:nature, :description, :prix, :caution)
    end
end
