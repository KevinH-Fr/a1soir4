class ClientsController < ApplicationController
  before_action :set_client, only: %i[ show edit update destroy ]

  def index
  #  @clients = Client.all
 
 # @pagy, @clients = pagy(Client.order(created_at: :desc), items: 5)

#    @q = Client.ransack(params[:q])
#    if @q.present?  
#      @clients = @q.result(distinct: true)
#    end


   #@pagy, @clients = pagy(Client.order(created_at: :desc), items: 10)
  #  respond_to do |format|
  #    format.html
  #    format.turbo_stream 
  #  end 

 # new 12 12

 #@clients = Client.all.order(created_at: :asc)
 
  search_params = params.permit(:format, :page, q:[:nom_or_prenom_or_mail_cont])
  @q = Client.ransack(search_params[:q])
  clients = @q.result(distinct: true).order(created_at: :asc)
  @pagy, @clients = pagy_countless(clients, items: 2)



  end

  def show
    @commandes = Commande.client_courant(@client)
  end

  def new
    @client = Client.new
    @typepropart = Client.typeproparts
    @intitule = Client.intitules
  end

  def edit
    @typepropart = Client.typeproparts
    @intitule = Client.intitules
    
    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@client, partial: "clients/form", 
          locals: {client: @client})
      end
    end
  end

  def create
    @client = Client.new(client_params)

    respond_to do |format|

      if @client.save
       
       flash.now[:notice] = "le client #{@client.nom} a été ajouté à #{Time.zone.now}"

       format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("clients", partial: "clients/client",
            locals: {client: @client }), 
            turbo_stream.update("client_counter", Client.count),
            turbo_stream.update("flash", partial: "layouts/flash"),
          ]
       end

        format.html { redirect_to client_url(@client), notice: "Client was successfully created." }
        format.json { render :show, status: :created, location: @client }
 
       
      else

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_client', partial: "clients/form", 
              locals: {client: @client  }),
          ]
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update(client_params)

        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@client, partial: "clients/client", 
            locals: {client: @client})
        end

        format.html { redirect_to client_url(@client), notice: "Client was successfully updated." }
        format.json { render :show, status: :ok, location: @client }
      else

        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@client, partial: "clients/form", 
            locals: {client: @client})
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client.destroy

    flash.now[:notice] = "le client #{@client.nom} a été supprimé à #{Time.zone.now}"

    respond_to do |format|

      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@client),
          turbo_stream.update("client_counter", Client.count),
          turbo_stream.update("flash", partial: "layouts/flash")
        ]
      end

      format.html { redirect_to clients_url, notice: "Client was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.fetch(:client, {}).permit(:nom, :prenom, :typepropart, :contact, :intitule,
        :mail, :mail2, :tel, :tel2, :adresse, :ville, :cp, :pays, :commentaires)
    end
end
