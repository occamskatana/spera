class Api::V1::UsersController < Api::V1::BaseController

	def index
		if params[:search]
			users = User.search("#{params[:search]}")
			render json: users, each_serializer: UserSerializer, root: false
		else
			render json: {message: "nope"}
		end
	end

	def show
		default_serializer_options
		friend = User.find(params[:id])
			
		render json: friend, serializer: UserSerializer, root: false, status: 201			
	end


	def friend_list
		user = current_user
		friends = current_user.friends.to_a

		render json: friends, each_serializer: UserSerializer, root: false
	end
end