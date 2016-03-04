class GoalsController < ApplicationController
  respond_to :json, :html

  before_action :set_goals, only: [:show, :edit, :update, :destroy]
  def new
  @user = current_user
  @goal = @user.goals.new
  end

  def create
    @user = current_user
    goal = Goal.find_by title: "#{params["goal"]["title"]}"

    if goal == nil
      @goal = Goal.create(goal_params)
      @goal.save
      Objective.create!(goal: @goal, user: current_user, date: params[:date], description: params[:description])
    else
      Objective.create!(goal: goal, user: current_user, date: params[:date], description: params[:description])
    end
   
    redirect_to user_path(current_user)
  end

  def index
    @user = User.find(params[:user_id])
    @goals = @user.goals.all 

    render json: @goals
  end

  def update
  end

  def edit
  end

  def destroy
  end

private

  def goal_params
    params.require(:goal).permit(:title, :description, schedule_attributes: Schedulable::ScheduleSupport.param_names)
  end
end
