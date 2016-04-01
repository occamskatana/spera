class GroupableSerializer < ActiveModel::Serializer

	attributes :id, :group_name, :from_user

	def group_name
		object.group.name
	end	

	def from_user
		object.user.first_name + " " + object.user.last_name
	end

end