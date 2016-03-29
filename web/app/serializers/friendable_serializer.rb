class FriendableSerializer < ActiveModel::Serializer 

	attributes :id, :to_id, :from_id, :accepted, :to_user, :from_user, :chat_id, :chat_messages

	def to_user
		User.find(object.to_id).username
	end

	def from_user
		User.find(object.from_id).username
	end

	def chat_id
		object.chat ? object.chat.id : 'nil'
	end

	def chat_messages
		object.chat.messages if object.chat
	end

end