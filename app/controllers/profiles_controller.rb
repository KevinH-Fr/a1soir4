class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update destroy ]

  def index
    @profiles = Profile.all
  end


  def show
  end


  def new
    @profile = Profile.new
  end


  def edit

    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@profile, partial: "profiles/form", 
          locals: {profile: @profile})
      end
    end

  end

  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save

        flash.now[:notice] = "le profile #{@profile.nom} a été ajouté à #{Time.zone.now}"

        format.turbo_stream do
           render turbo_stream: [
             turbo_stream.prepend("profiles", partial: "profiles/profile",
             locals: {profile: @profile }), 
             turbo_stream.update("profile_counter", Profile.count),
             turbo_stream.update("flash", partial: "layouts/flash"),
           ]
        end

        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully created." }
        format.json { render :show, status: :created, location: @profile }
      else

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_profile', partial: "profiles/form", 
              locals: {profile: @profile  }),
          ]
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)

        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@profile, partial: "profiles/profile", 
            locals: {profile: @profile})
        end

        format.html { redirect_to profiles_url, notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1 or /profiles/1.json
  def destroy
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url, notice: "Profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:prenom, :nom, :image1)
    end
end
