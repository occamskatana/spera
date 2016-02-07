class ObjectiveSerializer < ActiveModel::Serializer 
	attributes :id, :user, :goal, :date, :description
end