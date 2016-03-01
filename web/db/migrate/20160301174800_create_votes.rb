class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.integer :value
      t.references :user, index: true, foreign_key: true
      t.references :board, index: true, foreign_key: true
    end
  end
end
