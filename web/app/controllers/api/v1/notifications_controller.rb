class Api::V1::NotificationsController < Api::V1::BaseController

	def index
		user = current_user
		alerts = current_user.notifications
		render json: alerts, root: false
	end

	def update

	end
end