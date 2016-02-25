class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    before_save {self.private ||= :true}
      
    has_many :checkins
    has_many :objectives
    has_many :goals, through: :objectives
    has_many :friendables
    has_many :users, through: :friendables
    has_many :posts
    has_many :events

    def friend_list
        relations = Friendable.all.select do |f|
    		f.accepted == true && f.to_id == self.id || f.from_id == self.id 
    	end
    	friends_ids = Array.new
	    relations.each do |r|
	    	if r.from_id == self.id 
	    		friend_id = r.to_id 
	    	else r.to_id == self.id 
	    		friend_id = r.from_id 
	    	end
	    	
	    	friends_ids << friend_id
	    end  
	    return friends_ids
    end

    def friends

    	buddies = []
    	friend_list.each do |f|
    	buddies <<	User.find(f)
    	end
    	return buddies
    end

    def notifications
        Notification.where({to_id: self.id, viewed: false})
    end

    def self.search(search)
        where("username LIKE :search OR first_name LIKE :search OR last_name LIKE :search", search: "%#{search}%")
    end

    
end
