class PhotoSetupJob

  def self.perform(*args)
    files = Dir.glob("app/assets/images/food/*")
	file_names = files.map { |f| f.gsub("app/assets/images/food/", "") } 
	file_names.each { |f| Photo.create(asset_name: f) }
  end
end
