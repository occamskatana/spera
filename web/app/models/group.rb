class Group < ActiveRecord::Base
	has_many :groupables
	has_many :users, through: :groupables
	has_one :chat
end
