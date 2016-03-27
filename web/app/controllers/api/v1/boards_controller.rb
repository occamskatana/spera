class Api::V1::BoardsController < Api::V1::BaseController
	respond_to :json

	def index
		boards = Board.all
		render json: boards, each_serializer: BoardSerializer, status: 201, root: false
	end

	def show
		board = Board.find(params[:id])
		render json: board, serializer: BoardSerializer, status: 201, root: false
	end

	def create
		puts params
		board = Board.create!(board_params)
		render json: board, serializer: BoardSerializer, status: 301
	end


private
	
	def board_params
		params.require(:board).permit(:title, :description, :user)
	end
	
end