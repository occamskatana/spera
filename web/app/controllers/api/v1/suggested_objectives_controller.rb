class Api::V1::SuggestedObjectivesController < Api::V1::BaseController

	def index
		suggested_objs = SuggestedObjective.all
		render json: suggested_objs, root: false
	end

end