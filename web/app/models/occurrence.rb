class Occurrence < ActiveRecord::Base
  belongs_to :objective
  belongs_to :user

  def mark_complete
  	self.update_attributes({completed: true})
  end
end
