class AddingAssetNameToPhoo < ActiveRecord::Migration[5.2]
  def change
  	add_column :photos, :asset_name, :string
  end
end
