class Event < ActiveRecord::Base
  belongs_to :user
  has_many :notifications

  after_create :notify_friends

  def notify_friends
  	self.user.friend_list.each do |user|
  		Notification.create!(to_id: user, event_id: self.id, name: self.name, viewed: false)
  	end
  end

  

  
end
