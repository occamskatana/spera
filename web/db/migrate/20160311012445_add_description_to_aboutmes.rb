class AddDescriptionToAboutmes < ActiveRecord::Migration
  def change
    add_column :aboutmes, :description, :text
  end
end
