class Api::V1::UsersController < Api::V1::BaseController
	respond_to :json

	def default_serializer_options
    {each_serializer: Api::V1::UserSerializer } # I use each_serializer instead of serializer because it's rendering a collection.
  end

	def index
			user = current_user
				
			friends = current_user.friends.to_a

		render json: friends.to_json, status: 201
	end

	def show
		
			default_serializer_options

			@user = User.find(params[:id])
			
			render json: @user.to_json, status: 201			
	end
end