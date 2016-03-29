class Api::V1::FriendsController < Api::V1::BaseController

	def index
		if params[:user_id]
			user = User.find(params[:user_id])
			users = User.find(user.friend_list)
			render json: users, status: 201, root: false
		else
			render json: {error: "Please provide a user_id"}, status: 422
		end
	end

	# NOTE THIS FOR CHATS FOR NOW, NOT VERY CLEAR. This is bad...
	def show
		friend_id = params[:id]
		friendship = Friendable.where(from_id: current_user.id, to_id: friend_id).first || 
								 Friendable.where(to_id: current_user.id, from_id: friend_id).first
		render json: friendship
	end

end