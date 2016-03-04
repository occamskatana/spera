class AddScheduleToObjectives < ActiveRecord::Migration
  def change
    add_column :objectives, :schedule, :text
  end
end
