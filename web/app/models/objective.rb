class Objective < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal
  has_many :occurrences, dependent: :destroy
  after_create :build_occurrences

  validates_presence_of :title

  before_save {self.completed ||= :false}

  def build_occurrences
  	if self.recurring == 'daily'
	  	Occurrence.create!(objective_id: self.id, user: self.user, date: self.date, completed: false)
			$i = 0
			until $i >= self.length do 
				Occurrence.create!(objective_id: self.id, user: self.user, date: self.date += 1.day, completed: false)
				$i += 1
			end
		elsif self.recurring == 'weekly'
			Occurrence.create!(objective_id: self.id, user: self.user, date: self.date, completed: false)
			$i = 0
			until $i >= self.length do 
				Occurrence.create!(objective_id: self.id, user: self.user, date: self.date += 7.day, completed: false)
				$i += 1
			end
		else
			# should create single occurence on date they specify
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

  def total_times_due
  	self.occurrences.where("date < ?", Date.today).count
  end

  # Does NOT handle case where there are multiple occurrences for same goal in a given day
  def streak_count
  	all = self.occurrences.where("date < ?", Date.today).order(:date).reverse
		completed = 0
		if !all.empty?
			index = 0
			while all[index].completed && index < (all.length - 1)
				completed += 1
				index += 1
			end
  	end
  	completed
  end

end
