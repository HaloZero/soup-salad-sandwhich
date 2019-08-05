class AddSessionIdToFoodVote < ActiveRecord::Migration[5.2]
  def change
  	add_column :food_votes, :session_id, :string

  end
end
