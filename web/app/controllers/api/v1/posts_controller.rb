class Api::V1::PostsController < Api::V1::BaseController
	respond_to :json

	def create
		board = Board.find(params[:board_id])
		post = board.posts.create!(post_params)

		render json: post, status: 200
	end



private

	def post_params
		params.require(:post).permit(:user_id, :title, :content)
	end

end