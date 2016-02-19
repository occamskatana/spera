class Objective < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  before_save {self.completed ||= :false}

  default_scope {order('date DESC')}

  def day 
  	self.date.strftime('%D')
  end

  
  def unfuck_the_fucking_date
  	self.date.strftime(("%B %d, %Y"))
  end

end
