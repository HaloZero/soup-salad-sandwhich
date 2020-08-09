class VoteController < ApplicationController

	def index()
		session_id = session[:session_id]
		@food_name = _find_food_to_vote(session_id)
		response = _find_food_images(@food_name)
		@html_to_embed = response['html']
	end

	def create()
		session_id = session[:session_id]
		food_name = params[:food_name]
		food_type = params[:food_type].to_s

		existing_vote = FoodVote.where(session_id: session_id, name: food_name)
		if food_name == nil || food_type == nil
			head 400
			return
		end

		if existing_vote.empty?
			FoodVote.create(session_id: session_id, name: food_name, food_type: food_type)
			head :ok, :content_type => "text/javascript"
		end
	end

	def results
		votes = FoodVote.unscoped.all
		food_names = Food.food_mapping.keys
		results = []
		food_names.each do |food_name|
			votes_for_food = votes.select { |v| v.name == food_name }
			response = _find_food_images(food_name)
			html_to_embed = response['html']
			vote_json = {
				food: food_name,
				html_to_embed: html_to_embed,
				soup: votes_for_food.select { |v| v.food_type == 'soup' }.count,
				sandwich: votes_for_food.select { |v| v.food_type == 'sandwich' }.count,
				salad: votes_for_food.select { |v| v.food_type == 'salad' }.count,
			}
			results.append(vote_json)
		end

		@results = results
	end

	def _find_food_to_vote(session_id)
		foods_voted = FoodVote.where(session_id: session_id).map { |x| x.name }
		remaining_foods = Food.food_mapping.keys.shuffle - foods_voted
		return remaining_foods.first
	end

	def _find_food_images(food_name)
		embed_id = Food.food_mapping[food_name]
		response = HTTParty.get("http://embed.gettyimages.com/oembed?url=http%3a%2f%2fgty.im%2f#{embed_id}")
	end
end