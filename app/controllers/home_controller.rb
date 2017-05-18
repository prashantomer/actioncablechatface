class HomeController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: [:user_avatar]
  def index
  	session[:conversations] ||= []
 
    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])
  end

  def home
  	@user_profile = current_user.profile
  end

  def user_edit
    @profile = current_user.profile
    if request.put?
      debugger
      current_user.update(user_nested_params)
      flash[:notice] = "Updated Successfully!!!"
      redirect_to root_path
    end
  end

  def user_avatar
  	# current_user.profile.remove_picture!
    begin
      pic = params.require(:user_profile).require(:picture)
      current_user.profile.update(picture: pic)
      render json: {status: true, image: current_user.profile.picture.url}
    rescue ActionController::ParameterMissing => e
      render json: {status: false, message: e.message}
    end
  end

  private
  def user_nested_params
    params.require(:user).permit(:email, :user_profile_attributes=>[:id, :first_name, :last_name, :picture, :cover, :_destroy])
  end
end
