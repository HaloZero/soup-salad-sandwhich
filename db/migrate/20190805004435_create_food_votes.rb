class CreateFoodVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :food_votes do |t|
      t.string :name

      t.timestamps
    end
  end
end
