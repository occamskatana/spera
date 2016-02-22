class FriendableSerializer < ActiveModel::Serializer 

	attributes :id, :to_id, :from_id, :accepted, :to_user, :from_user

	def to_user
		User.find(object.to_id).username
	end

	def from_user
		User.find(object.from_id).username
	end

end