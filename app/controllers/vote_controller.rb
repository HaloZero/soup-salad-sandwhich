class VoteController < ApplicationController

	def index()
		session_id = session[:session_id]
		@food_name = find_food_to_vote(session_id)
		if @food_name != nil
			search_results = find_food_images(@food_name)
			search_result = search_results.first
			@photo_url = search_result.urls.full
			@photographer_name = search_result.user.name
			@photographer_url = "https://unsplash.com/#{search_result.user.username}"
		end
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

	def find_food_to_vote(session_id)
		foods_voted = FoodVote.where(session_id: session_id).map { |x| x.name }
		remaining_foods = Food.food_list.shuffle - foods_voted
		return remaining_foods.first
	end

	def find_food_images(food_name)
		food_name = food_name.gsub("_", " ")
		search_results = Rails.cache.read(food_name)
		if search_results == nil
			search_results = Unsplash::Photo.search(food_name)
		end
	end
end

class VoteControllerLegacy < ApplicationController
	def index()
		session_id = session[:session_id]
		@photo = self.find_food_to_vote(session_id)
	end

	def create()
		session_id = session[:session_id]
		photo_id = params[:photo_id].to_i
		existing_vote = Vote.where(session_id: session_id, photo_id: photo_id)
		if existing_vote.empty?
			food_type = params[:food_type].to_s
			Vote.create(session_id: session_id, photo_id: photo_id, food_type: food_type)
			head :ok, :content_type => "text/javascript"
		end
	end

	def results()
		votes = Vote.all.includes(:photo)
		photos = votes.map { |v| v.photo }.uniq.sort

		results = []
		photos.each do |photo| 
			vote_for_photo = votes.select { |v| v.photo_id = photo.id }
			vote_json = {
				photo: photo.name,
				photo_url: photo.url,
				soup: vote_for_photo.select { |v| v.food_type == 'soup' }.count,
				sandwhich: vote_for_photo.select { |v| v.food_type == 'sandwhich' }.count,
				salad: vote_for_photo.select { |v| v.food_type == 'salad' }.count,
			}
			results.append(vote_json)
		end
		@results = results
	end

	def find_photo_to_vote(session_id)
		voted_photos = Vote.all.map { |x| x.photo_id }
		photo = Photo.where.not(id: voted_photos).shuffle.first
		return photo
	end
end
