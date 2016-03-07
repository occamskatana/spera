class ObjectiveSerializer < ActiveModel::Serializer 
	attributes :id, :date, :description, :title, :status

	def title
		object.goal.title
	end

	def status
		object.status
	end


	

	
end