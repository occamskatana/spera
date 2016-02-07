class ObjectivesController < ApplicationController
  def new
    @objective = Objective.new
  end

  def create
    @user = current_user
    @objective = @user.objectives.create(objective_params)

    if @objective.save
      flash[:notification] = "Yay"
    else
      flash[:error] = "boo"
    end

    respond_to do |format|
      format.json {render json: :show, status: :created, location: @objective}
      format.html {redirect_to user_path(current_user)}
  end

  def destroy
  end

  def edit
  end

  def update
  end

private

  def objective_params
    params.require(:objective).permit(:user, :goal, :date, :description)
  end


  def goal_title 
    Goal.find_or_create_by(params[:goal_title])
  end
end
