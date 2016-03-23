class AddRecurringToObjectives < ActiveRecord::Migration
  def change
    add_column :objectives, :recurring, :string
  end
end
