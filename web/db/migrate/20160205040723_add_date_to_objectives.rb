class AddDateToObjectives < ActiveRecord::Migration
  def change
    add_column :objectives, :date, :date
  end
end
