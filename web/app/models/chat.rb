class Chat < ActiveRecord::Base
  belongs_to :friendable
  belongs_to :group
  has_many :messages
end
