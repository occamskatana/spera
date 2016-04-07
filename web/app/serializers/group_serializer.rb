class GroupSerializer < ActiveModel::Serializer 

	attributes :id, :name, :description, :users, :chat_messages

	def users
		object.visible_members
	end

	def chat_id
		object.chat ? object.chat.id : 'nil'
	end

	def chat_messages
		object.chat.messages if object.chat
	end

end