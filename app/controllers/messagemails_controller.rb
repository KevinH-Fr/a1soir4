class MessagemailsController < ApplicationController
  before_action :set_messagemail, only: %i[ show edit update destroy ]

  # GET /messagemails or /messagemails.json
  def index
    @messagemails = Messagemail.all
  end

  # GET /messagemails/1 or /messagemails/1.json
  def show
  end

  # GET /messagemails/new
  def new
    @messagemail = Messagemail.new
  end

  # GET /messagemails/1/edit
  def edit
  end

  # POST /messagemails or /messagemails.json
  def create
    @messagemail = Messagemail.new(messagemail_params)

    respond_to do |format|
      if @messagemail.save
       
          #ajouter ici un call de la fonction envoi mail client ?

     # client = Client.find(params[:clientId])
      messagemail = @messagemail
  
      MessagemailMailer.with(messagemail: messagemail).messagemail_created(messagemail).deliver_now
        flash[:notice] = "le mail a bien été envoyé"
       # redirect_to messagemails_path()

        format.html { redirect_to messagemail_url(@messagemail), notice: "Le mail a bien été créé." }
        format.json { render :show, status: :created, location: @messagemail }
  
     
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @messagemail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messagemails/1 or /messagemails/1.json
  def update
    respond_to do |format|
      if @messagemail.update(messagemail_params)
        format.html { redirect_to messagemail_url(@messagemail), notice: "Messagemail was successfully updated." }
        format.json { render :show, status: :ok, location: @messagemail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @messagemail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messagemails/1 or /messagemails/1.json
  def destroy
    @messagemail.destroy

    respond_to do |format|
      format.html { redirect_to messagemails_url, notice: "Messagemail was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def send_messagemail_mail

    client = Client.find(params[:clientId])

    messagemail = Messagemail.find(params[:messagemailId])

    MessagemailMailer.with(client: client).messagemail_created(client, messagemail).deliver_now
      flash[:notice] = "le mail a bien été envoyé"
      redirect_to messagemails_path()

  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_messagemail
      @messagemail = Messagemail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def messagemail_params
      params.require(:messagemail).permit(:titre, :body, :commande_id, :client_id, :mail)
    end
end
