class Api::V1::GroupsController < Api::V1::BaseController

	def index
		groups = current_user.groups

		render json: groups, status: 200
	end

	def show
		group = Group.find(params[:id])

		render json: group, status: 200
	end

end