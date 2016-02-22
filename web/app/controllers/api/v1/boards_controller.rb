class Api::V1::BoardsController < Api::V1::BaseController
	respond_to :json

	def index
		boards = Board.all
		render json: boards.to_json
	end

	def show
		board = Board.find(params[:id])
		render json: BoardSerializer.new(board).to_json
	end

end