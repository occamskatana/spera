class Api::V1::FriendablesController < Api::V1::BaseController

	def index
		friend_requests = current_user.friend_requests
		render json: friend_requests, status: 201, root: false
	end

	def show
		
		render json: Friendable.where(id: params[:id]), status: 201, root: false

	end

end