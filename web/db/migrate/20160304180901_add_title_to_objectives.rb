class AddTitleToObjectives < ActiveRecord::Migration
  def change
    add_column :objectives, :title, :string
  end
end
