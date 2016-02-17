class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.boolean :use
      t.integer :mood
      t.text :remarks
      t.boolean :need_support
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
