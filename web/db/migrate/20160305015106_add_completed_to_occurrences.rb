class AddCompletedToOccurrences < ActiveRecord::Migration
  def change
    add_column :occurrences, :completed, :boolean
  end
end
