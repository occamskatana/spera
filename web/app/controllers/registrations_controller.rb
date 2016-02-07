class RegistrationsController < Devise::RegistrationsController
	respond_to :json, :html

private 

	def sign_up_params
		params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :username)
	end

	def account_update_params
		params.require(:user).permit(:email, :password_confirmation, :password, :first_name, :last_name, :username, :current_password)
	end

end