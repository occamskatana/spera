class Api::V1::UsersController < Api::V1::BaseController
	respond_to :json

	def index
			user = current_user
				
			friends = current_user.friends.to_a

		render json: friends.to_json, status: 201
	end

	def show
			
			@friend = User.find(params[:id])
			
			render json: @friend.to_json, status: 201			
	end
end