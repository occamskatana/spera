class OccurrenceSerializer < ActiveModel::Serializer 
	attributes :id, :completed, :title, :description, :time

	def title
		object.objective.title
	end

	def description
		object.objective.description
	end

	def time
		object.objective.reminder_time.strftime("%I:%M %p")
	end

	# def completed
	# 	object.completed
	# end

end