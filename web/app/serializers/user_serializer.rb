class UserSerializer < ActiveModel::Serializer
	attributes :id, :first_name, :last_name, :last_checkin

	def last_checkin
		object.checkins.last
	end
	

	

end