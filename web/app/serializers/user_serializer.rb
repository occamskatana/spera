class UserSerializer < ActiveModel::Serializer
	attributes :id, :first_name, :last_name, :sober_date, :last_checkin, :username, :notifications

	def last_checkin
		object.checkins.last
	end
	
	def sober_date
		Faker::Date.between(5.years.ago, Date.today)
	end

	def notifications
		object.show_event
	end

	

end