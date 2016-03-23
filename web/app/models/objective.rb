class Objective < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal
  has_many :occurrences, dependent: :destroy
  after_create :build_occurrences

  validates_presence_of :title

  before_save {self.completed ||= :false}

  def build_occurrences
  	Occurrence.create!(objective_id: self.id, user: self.user, date: self.date, completed: false)
		$i = 0
		until $i >= self.length do 
			Occurrence.create!(objective_id: self.id, user: self.user, date: self.date += 1.day, completed: false)
			$i += 1
		end
	end

	# def status 
	# 	total = self.occurrences.count
	# 	completed = self.occurrences.where(completed: true).count
	# 	percentage_complete = (completed / total)
	# 	return percentage_complete
	# end

	def daily
		self.occurrences.where(date: Date.today)
	end

  def day 
  	self.date.strftime('%D')
  end

  
  def unfuck_the_fucking_date
  	self.date.strftime(("%B %d, %Y"))
  end

end
