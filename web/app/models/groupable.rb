class Groupable < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  def joined
  	self.where(accepted: true)
  end

  def pending
  	self.where(accepted: false)
  end
end
