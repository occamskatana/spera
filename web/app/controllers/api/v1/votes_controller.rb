class Api::V1::VotesController < Api::V1::BaseController

	def down_vote
		update_vote(-1)
		redirect_to :back
	end

	def up_vote
		update_vote(1)
		render json: {message: "success"}
	end


private

	def update_vote(new_value)
		@board = Board.find(params[:board_id])
		@vote = @board.votes.where(user_id: current_user.id).first

		if @vote
			@vote.update_attribute(:value, new_value)
		else
			@vote = current_user.votes.create!(value: new_value, board: @board)
		end
	end



end