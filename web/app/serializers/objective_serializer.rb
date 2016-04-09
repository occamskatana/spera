class ObjectiveSerializer < ActiveModel::Serializer 
	attributes :id, :date, :description, :title, :length, :recurring, :time, :times_completed, :total_times_due, :streak_count

	# def status
	# 	object.status
	# end

	def time
		object.reminder_time.strftime("%I:%M%p")
	end
end