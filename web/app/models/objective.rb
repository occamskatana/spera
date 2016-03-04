class Objective < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal
  has_many :occurrences, dependent: :destroy
  after_create :build_occurrences

  before_save {self.completed ||= :false}

  def build_occurrences
		$i = 0
		until $i >= self.length do 
			Occurrence.create!(objective_id: self.id, user: self.user, date: self.date += 1.day)
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
