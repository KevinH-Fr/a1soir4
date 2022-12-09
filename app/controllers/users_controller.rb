class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :toggle_status]

    def index
       # call_action
    end 

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end


    def update
        respond_to do |format|
            if @user.update(friend_params)
              format.html { redirect_to user_url(@user), notice: "user was successfully updated." }
              format.json { render :show, status: :ok, location: @user }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
        
    end



    def toggle_status

      if @user.admin?
        @user.user!
      elsif @user.user?
        @user.admin!
      end

      redirect_to users_url, notice: "le rôle a bien été modifié"
    end


      private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
   

     # Only allow a list of trusted parameters through.
     def user_params
        params.require(:user).permit(:email, :username, :role)
      end
  

end
