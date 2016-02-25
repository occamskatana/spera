class NotificationSerializer < ActiveModel::Serializer 
	attributes :id, :name, :from_user

	def from_user
		object.event.user
	end
end