class PostSerializer < ActiveModel::Serializer 

	attributes :id, :title, :content, :username

	def username 
		object.user.username
	end

end