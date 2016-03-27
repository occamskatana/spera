class ChatSerializer < ActiveModel::Serializer 
	attributes :id, :messages

	def messages
		object.messages
	end

end