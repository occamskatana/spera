class Api::V1::OccurrencesController < Api::V1::BaseController
 def index
 		occurrences = Occurrence.where(user_id: current_user.id, date: Date.today, completed: false)
 		occurrences = occurrences.sort_by {|o| o.objective.reminder_time}
 		render json: occurrences, root: false, each_serializer: OccurrenceSerializer
 end

 def mark_complete
 		occurrence = Occurrence.find(params[:id])
 		occurrence.mark_complete
 		render json: occurrence, root: false
 end

end