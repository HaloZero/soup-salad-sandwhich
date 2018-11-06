class VoteController < ApplicationController

	def index()
		session_id = session[:session_id]
		@photo = self.find_photo_to_vote(session_id)
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
