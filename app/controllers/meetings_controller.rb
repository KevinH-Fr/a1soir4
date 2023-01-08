class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[ show edit update destroy ]

  def index
    @meetings = Meeting.all

    @meetings_periode = Meeting.where(
      start_time: Time.now.beginning_of_month.beginning_of_week..
      Time.now.end_of_month.end_of_week)

 end

  def show
  end


  def new
    @meeting = Meeting.new

    @commandeId = params[:id]
    session[:commandeId] = @commandeId


  end


  def edit

    @commandeId = params[:id]
    session[:commandeId] = @commandeId

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

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to commande_url(@meeting.commande_id), notice: "Meeting was successfully updated." }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1 or /meetings/1.json
  def destroy
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to meetings_url, notice: "Meeting was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.fetch(:meeting, {}).permit(:name, :start_time, :end_time, :commande_id)
    end
end
