class AddingUserIdToVotes < ActiveRecord::Migration[5.2]
  def change
  	add_column :votes, :session_id, :string
  	add_index :votes, :session_id
  end
end
