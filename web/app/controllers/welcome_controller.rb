class WelcomeController < ApplicationController
  def index
  	user = current_user

  	if user_signed_in?
  		redirect_to user_path(user)
  	else
  		render :index
  	end
  end

end
