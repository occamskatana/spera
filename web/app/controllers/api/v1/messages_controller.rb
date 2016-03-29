class Api::V1::MessagesController < Api::V1::BaseController
	
	def create
		message = current_user.messages.create(message_params)
		render json: message
	end

	private

	def message_params
		params.require(:message).permit(:chat_id, :content)
	end
end