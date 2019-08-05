class Food
	def self.food_list
		[
			'spaghetti', 'cheeseburger', 'cinnamon_churro', 'ramen', 'chicken_wings',
			'muffin', 'ice_cream', 'popcorn', 'chicken_taco',
			'lasagna', 'poke_bowl', 'donut', 'crab_roll',
			'pepperoni_pizza', 'apple_pie', 'nachos', 'fried_chicken', 'clam_chowder',
			'macaroni_and_cheese', 'fortune_cookie', 'hot_dog', 'chocolate_chip_cookie',
			'shish_kebab', 'cinnamon_bun',
		]
	end

	# overrides so the search can get a better image
	def self.food_search_overrides(food)
		return
		{
			'cheeseburger': 'cheeseburger_bacon_bun'
		}[food]
	end
end