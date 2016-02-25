class Api::V1::EventsController < Api::V1::BaseController

	def index
		user = current_user
		events = user.events

		render json: events, status: 201, root: false
	end

	def create
		puts params
		user = current_user
		event = current_user.events.create!(user_id: current_user.id, name: params[:title])
		render json: event

	end

	private


end