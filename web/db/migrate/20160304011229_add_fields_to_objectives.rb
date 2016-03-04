class AddFieldsToObjectives < ActiveRecord::Migration
  def change
    add_column :objectives, :start_date, :date
    add_column :objectives, :every, :string
    add_column :objectives, :end_date, :date
  end
end
