class AddCompletedToObjective < ActiveRecord::Migration
  def change
    add_column :objectives, :completed, :boolean
  end
end
