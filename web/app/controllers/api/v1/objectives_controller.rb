class Api::V1::ObjectivesController < Api::V1::BaseController

	def index
		user = current_user
		goal = Goal.find(params[:goal_id])
		objectives = Objective.where(user_id: user.id, goal_id: goal.id) 
		render json: objectives, status: 201, root: false
	end

	def create
		goal = Goal.find(params[:goal_id])

		render json: objective
	end

	def show
		user = current_user
		objective = Objective.find(params[:id])

		render json: objective, status: 201, root: false
	end


	private

	def objective_params
		params.require(:objective).permit(:goal, :title, :user, :date, :description, schedule_attributes: Schedulable::ScheduleSupport.param_names )
	end

end