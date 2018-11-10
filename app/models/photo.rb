class Photo < ApplicationRecord
	def image_url()
		if self.url != nil
			url
		else
			ActionController::Base.helpers.asset_path("food/#{self.asset_name}")
		end
	end
end
