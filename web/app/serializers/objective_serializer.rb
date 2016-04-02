class ObjectiveSerializer < ActiveModel::Serializer 
	attributes :id, :date, :description, :title, :length, :recurring, :times_completed

	# def status
	# 	object.status
	# end

end