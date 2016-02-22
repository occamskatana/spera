class Api::V1::CheckinsController < Api::V1::BaseController
	respond_to :json

	def create
		user = current_user
		checkin = user.checkins.new(checkin_params)

		if checkin.valid?
			checkin.save!
			render json: checkin.to_json, status: 201
		else
			render json: {error: "Checkin isn't gonna work", status: 400}, status: 400
		end
	end

	def show
		user = User.find(params[:user_id])
		checkin = user.checkin.find(params[:id])
		render json: checkin.to_json, status: 200
	end

	def index
		user = User.find(params[:user_id])
		checkins = user.checkins
		render json: checkins.to_json, status: 200
	end


	private

	def checkin_params
		params.require(:checkin).permit(:user, :sober, :mood, :remarks, :need_support)
	end

end