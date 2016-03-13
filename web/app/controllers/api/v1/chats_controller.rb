class Api::V1::ChatsController < Api::V1::BaseController
	def show
		chat = Chat.find(params[:id])
		render json: chat
	end
end