class AddDateToOccurrences < ActiveRecord::Migration
  def change
    add_column :occurrences, :date, :date
  end
end
