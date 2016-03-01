class BoardSerializer < ActiveModel::Serializer 

	attributes :id, :title, :description, :points
	has_many :posts

	

end