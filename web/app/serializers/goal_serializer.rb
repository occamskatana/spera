class GoalSerializer < ActiveModel::Serializer 

	attributes :id, :title, :description
	has_many :objectives

	

	
end