class EventSerializer < ActiveModel::Serializer 
	attributes :name, :user_id, :user 

	def user
		User.find(object.user_id)
	end
end