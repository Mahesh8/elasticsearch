class UsersController < ApplicationController
before_action :set_user, only: [:show, :delete]

def index
      @users = User.all
end

def show
	 
end

def destroy
   @document.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
end



private
 def set_user
 	@user = User.find(params[:id])
 end
 
 def user_params
 	params.require(:user).permit(:email, :encrypted_password )
 end

end
