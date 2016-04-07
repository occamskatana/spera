class Group < ActiveRecord::Base
	has_many :groupables
	has_many :users, through: :groupables
	has_one :chat

	def visible_members
		members = []
		Groupable.where(group_id: self.id, accepted: true).each do |g|
			members << User.find(g.user_id)
		end
		return members.uniq!
	end

	def pending_members
		members = []
		Groupable.where(group_id: self.id, accepted: false).each do |g|
			members << User.find(g.user_id)
		end
		return members.uniq!
	end
end
