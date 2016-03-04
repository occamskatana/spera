class Api::V1::ObjectivesController < Api::V1::BaseController

	def index
		user = current_user
		objectives = user.objectives.all 
		render json: objectives, status: 201, root: false
	end

	def create
		objective = Objective.create(objective_params)

		goal = Goal.find_by title: "#{params["objective"]["title"]}"

		if goal == nil
			goal = Goal.create!(title: objective.title, description: objective.description)
			objective.goal = goal
		else
			objective.goal = goal 
		end

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