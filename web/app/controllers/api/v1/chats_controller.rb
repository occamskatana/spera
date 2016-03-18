class Api::V1::ChatsController < Api::V1::BaseController
	def show
		chat = Chat.find(params[:id])
		render json: chat
	end

	def create
		chat = Chat.create(chat_params)
		render json: chat, status: 201
	end

	private

	def chat_params
		params.require(:chat).permit(:group_id)
	end
end