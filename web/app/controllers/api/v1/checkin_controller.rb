class Api::V1::CheckinController < Api::V1::BaseController


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
		user = current_user
		checkin = user.checkin.find(params[:id])
		render json: checkin.to_json, status: 200
	end


	private

	def checkin_params
		params.require(:checkin).permit(:user, :use, :mood, :remarks, :need_support)
	end

end