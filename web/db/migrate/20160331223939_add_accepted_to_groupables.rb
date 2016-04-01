class AddAcceptedToGroupables < ActiveRecord::Migration
  def change
    add_column :groupables, :accepted, :boolean
  end
end
