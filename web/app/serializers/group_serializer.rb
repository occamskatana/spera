class GroupSerializer < ActiveModel::Serializer 

	attributes :id, :name, :description, :users


	def users
		object.users
	end

end