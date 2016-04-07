class BoardSerializer < ActiveModel::Serializer 
	attributes :id, :title, :description, :points, :rank, :username
	has_many :posts

	def username
		object.user.username
	end
end