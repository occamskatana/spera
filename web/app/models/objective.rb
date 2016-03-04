class Objective < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  acts_as_schedulable :schedule

  before_save {self.completed ||= :false}

  

  def day 
  	self.date.strftime('%D')
  end

  
  def unfuck_the_fucking_date
  	self.date.strftime(("%B %d, %Y"))
  end

end
