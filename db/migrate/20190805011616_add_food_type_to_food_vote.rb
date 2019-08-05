class AddFoodTypeToFoodVote < ActiveRecord::Migration[5.2]
  def change
  	add_column :food_votes, :food_type, :string
  end
end
