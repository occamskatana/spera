class AddHasReminderToObjectives < ActiveRecord::Migration
  def change
    add_column :objectives, :has_reminder, :boolean
  end
end
