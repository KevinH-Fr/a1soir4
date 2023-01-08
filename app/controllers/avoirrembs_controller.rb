class AvoirrembsController < ApplicationController
  before_action :set_avoirremb, only: %i[ show edit update destroy ]

  # GET /avoirrembs or /avoirrembs.json
  def index
    @avoirrembs = Avoirremb.all
  end

  def show
  end

  def new
    @avoirremb = Avoirremb.new avoirremb_params
    @commandeId = params[:commandeId]
    session[:commandeId] = params[:commandeId]
  end

  # GET /avoirrembs/1/edit
  def edit
    @commandeId = params[:commandeId]

    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@avoirremb, partial: "avoirrembs/form", 
          locals: {avoirremb: @avoirremb})
      end
    end
  end

  # POST /avoirrembs or /avoirrembs.json
  def create
    @avoirremb = Avoirremb.new(avoirremb_params)

    respond_to do |format|
      if @avoirremb.save
        format.html { redirect_to commande_url(@avoirremb.commande_id), notice: "Avoirremb was successfully created." }
        format.json { render :show, status: :created, location: @avoirremb }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @avoirremb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /avoirrembs/1 or /avoirrembs/1.json
  def update
    respond_to do |format|
      if @avoirremb.update(avoirremb_params)
        format.html { redirect_to commande_url(@avoirremb.commande_id), notice: "Avoirremb was successfully updated." }
        format.json { render :show, status: :ok, location: @avoirremb }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @avoirremb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avoirrembs/1 or /avoirrembs/1.json
  def destroy
    @avoirremb.destroy

    respond_to do |format|
      format.html { redirect_to commande_url(params[:id]), notice: "Avoirremb was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avoirremb
      @avoirremb = Avoirremb.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def avoirremb_params
      params.fetch(:avoirremb, {}).permit(:typeavoirremb, :montant, :natureavoirremb, :commande_id)
    end
end
