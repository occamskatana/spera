class Api::V1::EventsController < Api::V1::BaseController

def index
	user = current_user
	events = user.show_event

	render json: events, status: 201, root: false
end


end