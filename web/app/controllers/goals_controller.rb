class GoalsController < ApplicationController

  before_action :set_goals, only: [:show, :edit, :update, :destroy]
  def new
  @user = current_user
  @goal = @user.goals.new
  end

  def create
    puts "#{goal_params}"
    @user = current_user
    goal = Goal.find_by title: "#{params["goal"]["title"]}"

    if goal == nil
      @goal = Goal.create(goal_params)
      @goal.save
      Objective.create!(goal: @goal, user: current_user, date: params[:date], description: params[:description] )
    else
      Objective.create!(goal: goal, user: current_user, date: params[:date], description: params[:description] )
    end
   
    redirect_to user_path(current_user)
  end

  def update
  end

  def edit
  end

  def destroy
  end

private

  def goal_params
    params.require(:goal).permit(:title, :description)
  end
end
