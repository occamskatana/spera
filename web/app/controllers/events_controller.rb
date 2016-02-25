class EventsController < ApplicationController
  def create
  	@event = Event.create!(user: current_user)
  	redirect_to :back
  end
end
