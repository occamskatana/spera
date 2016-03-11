class AboutmeSerializer < ActiveModel::Serializer 
	attributes :id, :user, :sober_date, :description


	def user
		object.user
	end
end