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
    has_many :votes
    has_one :aboutme
    has_many :groupables
    has_many :groups, through: :groupables
    has_many :messages
    has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: 'https://s3.amazonaws.com/spera-data/no-picture-default.jpg',
                               s3_credentials: {access_key_id: 'AKIAJMKZFYDRUDEZFXBA', secret_access_key: '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'}
                                # add s3_credentials to config with ENV variables
    # default_url: ActionController::Base.helpers.asset_path('no-picture-default.jpg')
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

    

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
	    return friends_ids.uniq.delete_if {|id| id == self.id}
    end

    def friend_requests
        friend_requests = Friendable.where(to_id: self.id, accepted: false).to_a.uniq!{|e| e.from_id}
    end

    def joined_groups
        
    end

    def check
        check = Array.new
        self.friend_requests.each do |x|
            check << x.from_id
        end
        puts check.uniq.count
    end 

    def friends

    	buddies = []
    	friend_list.each do |f|
    	buddies <<	User.find(f)
    	end
    	return buddies
    end

    def group_invites
        Groupable.where(user_id: self.id, accepted: false)
    end

    def notifications
        Notification.where({to_id: self.id, viewed: false})
    end

    def self.search(search)
        where("username LIKE :search OR first_name LIKE :search OR last_name LIKE :search", search: "%#{search}%")
    end

    
end
