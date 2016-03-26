class Api::V1::GoalsController < Api::V1::BaseController 
	respond_to :json

	def index
		user = current_user
		goals = user.goals.all
		render json: goals, status: 201
	end

	# Create action needs to be cleaned
	def create
		user = current_user
    goal = Goal.find_by title: "#{params["goal"]["title"]}"

    if goal == nil
      @goal = Goal.create(goal_params)
      @goal.save
      render json: @goal, status: 201
      @goal.objectives.create!(user: current_user, date: Date.today, title: "Complete #{@goal.title}", length: 1)
    else
      render json: goal, status: 201
      goal.objectives.create!(user: current_user, date: Date.today, title: "Complete #{goal.title}", length: 1)
    end
	end

	# Why are we grabbing current user?
	def show
		user = current_user
		goal = Goal.find(params[:id])

		render json: goal, status: 201, root: false
	end
	
private
	
	def goal_params
    params.require(:goal).permit(:title, :description)
  end
end