class Api::V1::FriendablesController < Api::V1::BaseController

	def index
		friend_requests = current_user.friend_requests
		render json: friend_requests, status: 201, root: false
	end

	def show
		friendable = Friendable.where(id: params[:id])
		render json: friendable, status: 201, root: false
	end

end