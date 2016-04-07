class AddTimesCompletedToObjectives < ActiveRecord::Migration
  def change
    add_column :objectives, :times_completed, :integer
  end
end
