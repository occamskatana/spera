class UserSerializer < ActiveModel::Serializer
	attributes :id, :first_name, :last_name, :sober_date, :last_checkin, :username, :notifications, :avatar, :sober_date

	def last_checkin
		object.checkins.last
	end
	
	def sober_date
		object.sober_date.strftime("%m/%d/%y")
	end

	def notifications
		object.notifications
	end

end