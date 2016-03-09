class GoalsController < ApplicationController
  respond_to :json, :html

  # before_action :set_goals, only: [:show, :edit, :update, :destroy]
  def new
  @user = current_user
  @goal = @user.goals.new
  end

  # def create
  #   @user = current_user
  #   goal = Goal.find_by title: "#{params["goal"]["title"]}"

  #   if goal == nil
  #     @goal = Goal.create!(goal_params)
  #     render json: @goal, status: 201, root: false
  #   else
  #     render json: goal, root: false
  #   end
  # end

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
    params.require(:goal).permit(:title, :description)
  end
end
