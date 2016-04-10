class Api::V1::MessagesController < Api::V1::BaseController
	
	def create
		message = current_user.messages.create(message_params)

		# get friendship id from chat id and then post data to Firebase :)
		chat_id = params[:chat_id]
		friendship = Chat.find(chat_id).friendable
		firebase = Firebase::Client.new('https://spera.firebaseio.com/')
		response = firebase.push("userMessages/#{friendship.id}", { content: params[:content], author_id: current_user.id })

		render json: message
	end

	private

	def message_params
		params.require(:message).permit(:chat_id, :content)
	end
end