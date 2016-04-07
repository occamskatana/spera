class AddReminderTimeToObjectives < ActiveRecord::Migration
  def change
    add_column :objectives, :reminder_time, :time
  end
end
