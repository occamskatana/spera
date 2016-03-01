class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :board

  after_save :update_board

  validates :value, inclusion: {in: [-1,1], message: "%{value} is not a valid vote."}, presence: true

  def update_board
  	board.update_rank
  end
end
