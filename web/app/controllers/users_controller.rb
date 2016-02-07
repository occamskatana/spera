class UsersController < ApplicationController
	respond_to :json, :html
  def show
  	@user = User.find(params[:id])
  	@objectives = @user.objectives.all
  	respond_to do |format|
  		format.json {render json: @user.to_json, status: 200}
  		format.html {@user}
  	end
  end
end
