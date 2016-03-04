class ObjectiveSerializer < ActiveModel::Serializer 
	attributes :id, :description, :title, :date

	def title
		object.goal.title
	end

	# def date
	# 	if object.dates.include(Date.today)
	# end


	

	
end