class AddDescriptionToObjectives < ActiveRecord::Migration
  def change
    add_column :objectives, :description, :text
  end
end
