class Group < ActiveRecord::Base
	has_many :groupables
	has_many :users, through: :groupables
end
