class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[ show edit update destroy ]

  def index
    @meetings = Meeting.all

    @meetings_periode = Meeting.where(
      start_time: Time.now.beginning_of_month.beginning_of_week..
      Time.now.end_of_month.end_of_week)

 end

  def show
    if @meeting.commande_id.present?
      @commande = Commande.find(@meeting.commande_id)
    end
    
    if @meeting.client_id.present?
      @client = Client.find(@meeting.client_id)
    end

  end


  def new
    @meeting = Meeting.new meeting_params

    @commandeId = params[:id]
    session[:commandeId] = @commandeId

    @clientId = ""
    session[:clientId] = @clientId

  end


  def edit

    @commandeId = @meeting.commande_id
    session[:commandeId] = @commandeId

    @clientId = @meeting.client_id
    session[:clientId] = @clientId

    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@meeting, partial: "meetings/form", 
          locals: {meeting: @meeting})
      end
    end
  end

  
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        if @meeting.commande_id.present?
          format.html { redirect_to commande_url(@meeting.commande_id), notice: "Meeting was successfully created." }
        else
          format.html { redirect_to meeting_path(@meeting), notice: "Meeting was successfully created." }
        end 
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        if @meeting.commande_id.present?
          format.html { redirect_to commande_url(@meeting.commande_id), notice: "Meeting was successfully updated." }
        else
          format.html { redirect_to meeting_path(@meeting), notice: "Meeting was successfully updated." }
        end 
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @meeting.destroy

    respond_to do |format|
      if @meeting.commande_id.present?
        format.html { redirect_to commande_url(@meeting.commande_id), notice: "Meeting was successfully destroyed." }
      else
        format.html { redirect_to meetings_url, notice: "Meeting was successfully destroyed." }
      end 
      format.json { head :no_content }
    end
  end


  def toggle_rendezvous_client
    clientId = params[:id]
    @meeting = Meeting.create(client_id: clientId) 
    redirect_to meeting_path(@meeting),
       notice: "rendez-vous client auto #{clientId}" 
    
  end


  private
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def meeting_params
      params.fetch(:meeting, {}).permit(:name, :start_time, :end_time, :commande_id, :client_id)
    end
end
