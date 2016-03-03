class BoardSerializer < ActiveModel::Serializer 

	attributes :id, :title, :description, :points, :rank
	has_many :posts

	

end