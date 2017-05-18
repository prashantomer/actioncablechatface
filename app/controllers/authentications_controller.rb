class AuthenticationsController < ApplicationController
	before_action :authenticate_user!, except: [:create]
	def create
		auth = request.env["omniauth.auth"]
	  user = User.find_by_provider_and_uid_and_email(auth["provider"], auth["uid"], auth["info"]["email"]) || User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || (User.find_by_email(auth["info"]["email"]).update_omniauth(auth) rescue nil) || User.create_with_omniauth(auth)
	  sign_in(:user, user)
	  redirect_to root_url, :notice => "Signed in!"
	end
end
