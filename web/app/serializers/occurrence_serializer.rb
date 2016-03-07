class OccurrenceSerializer < ActiveModel::Serializer 
	attributes :id, :completed, :title, :description

	def title
		object.objective.title
	end

	def description
		object.objective.description
	end

	# def completed
	# 	object.completed
	# end

end