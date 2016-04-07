class Occurrence < ActiveRecord::Base
  belongs_to :objective
  belongs_to :user

  def mark_complete
  	self.update_attributes({completed: true})
  	if !self.objective.times_completed?
  		self.objective.update_attributes({times_completed: 1})
  	else
  		self.objective.update_attributes({times_completed: self.objective.times_completed + 1})
  	end
  end
  
end
