class Api::V1::ObjectivesController < Api::V1::BaseController

	def index
		user = current_user
		goal = Goal.find(params[:goal_id])
		objectives = Objective.where(user_id: user.id, goal_id: goal.id) 
		render json: objectives, status: 201, root: false
	end

	def create
		goal = Goal.find(params[:goal_id])
		
		# Practicing with delayed job
		Notifier.delay(run_at: 5.seconds.from_now).notification_email(current_user)
		
		# Note that TIME ZONE IS CURRENTLY WRONG SO TIME IS WRONG
		
		if params[:title]
			if params[:has_reminder]
				reminder_time = params[:reminder_time].to_time
				objective = goal.objectives.create!(user: current_user, description: params[:description], title: params[:title], length: params[:length], recurring: params[:recurring], has_reminder: params[:has_reminder], reminder_time: reminder_time, date: Date.today)

				render json: objective, root: false, status: 201
			else
				objective = goal.objectives.create!(user: current_user, description: params[:description], title: params[:title], length: params[:length], recurring: params[:recurring], has_reminder: params[:has_reminder], date: Date.today)

				render json: objective, root: false, status: 201
			end
		else
			if params[:has_reminder]
				reminder_time = params[:reminder_time].to_time
				objective = goal.objectives.create!(user: current_user, description: params[:description], title: params[:suggested_title], length: params[:length], recurring: params[:recurring], has_reminder: params[:has_reminder], reminder_time: reminder_time, date: Date.today)

				render json: objective, root: false, status: 201
			else
				objective = goal.objectives.create!(user: current_user, description: params[:description], title: params[:suggested_title], length: params[:length], recurring: params[:recurring], has_reminder: params[:has_reminder], date: Date.today)

				render json: objective, root: false, status: 201
			end
		end
	end

	def show
		user = current_user
		objective = Objective.find(params[:id])

		render json: objective, status: 201, root: false
	end

end