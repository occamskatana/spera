class Objective < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  before_save {self.completed ||= :false}

  def dates(options={})
    options = {:every => every, :starts => start_date, :until => end_date}.merge(options)
    options[:on] = case options[:every]
    when 'year'
      [options[:starts].month, options[:starts].day]
    when 'week'
      options[:starts].strftime('%A').downcase.to_sym
    when 'day', 'month'
      options[:starts].day
    end
    Recurrence.new(options).events
  end

  def dates_between(start_date, end_date)
    # recurrences = Objective.between(start_date, end_date)

    recurrences.inject([]) do |dates, recurrence| 
      dates.concat(recurrence.dates(:starts => start_date, :until => end_date))
    end
  end

  

  def day 
  	self.date.strftime('%D')
  end

  
  def unfuck_the_fucking_date
  	self.date.strftime(("%B %d, %Y"))
  end

end
