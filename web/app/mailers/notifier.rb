class Notifier < ApplicationMailer

	def notification_email(user)
		@user = user
		mail(to: 'chase@sperahealth.com', subject: "#{@user.username} - you have a goal notification!")
	end

end
