class Goal < ActiveRecord::Base
	attr_accessor :date


  has_many :objectives
  has_many :users, through: :objectives

  
  before_save {self.title = title.downcase}


  

end	
