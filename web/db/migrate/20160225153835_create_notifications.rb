class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :event, index: true, foreign_key: true
      t.integer :to_id
      t.string :name

      t.timestamps null: false
    end
  end
end
