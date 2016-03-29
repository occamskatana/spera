class ObjectiveSerializer < ActiveModel::Serializer 
	attributes :id, :date, :description, :title, :length, :recurring

	# def status
	# 	object.status
	# end

end