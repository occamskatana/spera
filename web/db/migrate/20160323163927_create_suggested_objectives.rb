class CreateSuggestedObjectives < ActiveRecord::Migration
  def change
    create_table :suggested_objectives do |t|
      t.references :goal_id, index: true, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
