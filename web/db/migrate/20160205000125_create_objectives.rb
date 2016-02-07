class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.references :user, index: true, foreign_key: true
      t.references :goal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
