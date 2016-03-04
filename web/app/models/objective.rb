class Objective < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  before_save {self.completed ||= :false}

  def build_objectives
		$i = 0
		until $i >= self.length do 
			Objective.create!(title: self.title, description: self.description, date: self.date += 1.day)
			$i += 1
		end
	end

  def day 
  	self.date.strftime('%D')
  end

  
  def unfuck_the_fucking_date
  	self.date.strftime(("%B %d, %Y"))
  end

end
