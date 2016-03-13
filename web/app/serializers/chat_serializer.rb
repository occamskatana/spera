class ChatSerializer < ActiveModel::Serializer 
	has_many :messages

end