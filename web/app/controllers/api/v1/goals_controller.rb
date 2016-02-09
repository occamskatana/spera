class Api::V1::GoalsController < Api::V1::BaseController 
	# before_action :authenticated?
	respond_to :json

	def index
		
		objectives = current_user.objectives
			
		goals = current_user.goals.all
		render json: goals
	end

	def show
		goals = Goal.all

		render json: goals
	end
end