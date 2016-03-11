class AddPrivateToAboutmes < ActiveRecord::Migration
  def change
    add_column :aboutmes, :private, :boolean
  end
end
