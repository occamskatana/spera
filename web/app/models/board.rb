class Board < ActiveRecord::Base
  has_many :posts
  has_many :votes
  belongs_to :user

  def up_votes
		votes.where(value: 1).count
	end

	def down_votes
		votes.where(value: -1).count
	end

	def points
		votes.sum(:value)
	end

	def update_rank
		age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
		new_rank = points + age_in_days
		update_attribute(:rank, new_rank)
	end
end
