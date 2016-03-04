class AddLengthToObjectives < ActiveRecord::Migration
  def change
    add_column :objectives, :length, :integer
  end
end
