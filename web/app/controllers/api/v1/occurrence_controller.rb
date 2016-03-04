class Api::V1::OccurrenceController < Api::V1::BaseController
 def index
 		objective = Objective.find(params[:id])
 		occurrences = objective.occurrences.where(user_id: current_user.id)
 end

end