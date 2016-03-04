class Api::V1::GoalsController < Api::V1::BaseController 
	
	respond_to :json

	def index
		
		
		user = current_user
		objectives = user.objectives.all
			
		
		render json: objectives, status: 201
		
	end

	def create
		user = current_user

    goal = Goal.find_by title: "#{params["goal"]["title"]}"

    if goal == nil
      @goal = Goal.create(goal_params)
      @goal.save
      Objective.create!(goal: @goal, user: current_user, date: params[:date], description: params[:description] )
    else
      Objective.create!(goal: goal, user: current_user, date: params[:date], description: params[:description] )
    end
    render json: goal.to_json, status: 201
	end

	def show
		user = current_user
		goal = user.objectives.find(params[:id])

		render json: goal, status: 201, root: false
	end
	
private
	def goal_params
    params.require(:goal).permit(:title, :description)
  end
end