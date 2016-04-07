class Api::V1::GroupsController < Api::V1::BaseController

	def index
		groups = current_user.groups

		render json: groups, status: 200
	end

	def show
		group = Group.find(params[:id])
		
		render json: group, status: 200
	end

	def create
		user = current_user
		group = user.groups.create!(group_params)
		
		render json: group, status: 201
	end

	def invite
		group = Group.find(params[:id])
		Groupable.create!(user_id: params[:user_id], group: group, accepted: false )
	end

	def group_invites
		invites = Groupable.where(user_id: current_user.id, accepted: false)
		render json: invites, each_serializer: GroupableSerializer
	end

	def accept
		groupable = Groupable.find(params[:groupable_id])
		groupable.accepted = true 
		groupable.save
		render json: {message: "success", status: 200}, status: 200
	end

	def reject
		groupable = Groupable.find(params[:groupable_id])
		groupable.delete
	end

private

	def group_params
		params.require(:group).permit(:name, :description)
	end

end