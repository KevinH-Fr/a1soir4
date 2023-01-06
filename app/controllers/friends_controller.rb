class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]

  # GET /friends or /friends.json
  def index
    #@friends = Friend.all
    @pagy, @friends = pagy_countless(Friend.order(created_at: :desc), items: 2)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /friends/1 or /friends/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "friend_ #{@friend.id}",
                template: "friends/show",
                formats: [:html],
                disposition: :inline,
                layout: 'pdf'
      end
    end
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  def edit

    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@friend, partial: "friends/form", 
          locals: {friend: @friend})
      
      end
    end
  end

  # POST /friends or /friends.json
  def create
    @friend = Friend.new(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy

    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  def editer_pdf

    @friend = Friend.find(params[:id])

    pdf = WickedPdf.new.pdf_from_string(
      render_to_string(template: "friends/documentEdit", 
                       formats: [:html],
                       disposition: :inline,              
                       layout: 'pdf')
    )
    # Envoi du PDF en tant que fichier à télécharger
    send_data pdf,
      filename: "friend_" "#{@friend.id}",
      type: 'application/pdf',
      disposition: 'inline'

  end 

  def send_mail
    
    friend = Friend.find(params[:id])

    pdf = WickedPdf.new.pdf_from_string(
      render_to_string(template: "friends/documentEdit", 
                       formats: [:html],
                       disposition: :inline,              
                       layout: 'pdf')
    )
    
    FriendMailer.with(friend: friend, pdf: pdf).new_friend().deliver_now
      flash[:notice] = "le mail a bien été envoyé"
      redirect_to friend_path(friend)
    
  end 



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:name, :mail, :age, :image1)
    end
end
