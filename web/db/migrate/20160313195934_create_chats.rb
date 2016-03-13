class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.references :friendable, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps null: false
    end
  end
end
