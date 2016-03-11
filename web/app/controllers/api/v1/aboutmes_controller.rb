class Api::V1::AboutmesController < Api::V1::BaseController

	def index
		user = current_user
		aboutme = user.aboutme

		render json: aboutme, status: 200
	end

end