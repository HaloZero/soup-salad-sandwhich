class RenameColumn < ActiveRecord::Migration[5.2]
  def up
  	 rename_column :votes, :type, :food_type
  end
end
