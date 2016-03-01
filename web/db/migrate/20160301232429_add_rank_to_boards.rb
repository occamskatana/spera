class AddRankToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :rank, :float
  end
end
