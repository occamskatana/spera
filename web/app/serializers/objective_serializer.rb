class ObjectiveSerializer < ActiveModel::Serializer 
	attributes :id, :date, :description, :title

	def title
		object.goal.title
	end

	# def status
	# 	object.status
	# end


	

	
end