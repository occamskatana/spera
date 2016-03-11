class CreateAboutmes < ActiveRecord::Migration
  def change
    create_table :aboutmes do |t|
      t.references :user, index: true, foreign_key: true
      t.date :sober_date
      t.string :tagline

      t.timestamps null: false
    end
  end
end
