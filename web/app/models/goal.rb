class Goal < ActiveRecord::Base
	attr_accessor :date


  has_many :objectives
  has_many :users, through: :objectives
  acts_as_schedulable :schedule

  
  before_save {self.title = title.downcase}


  

end	
