class AddSoberDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sober_date, :date
  end
end
