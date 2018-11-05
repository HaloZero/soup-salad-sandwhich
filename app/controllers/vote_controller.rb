class VoteController < ApplicationController

	def index()
		session_id = session[:session_id]
		@photo = self.find_photo_to_vote(session_id)
	end

	def find_photo_to_vote(session_id)
		voted_photos = Vote.all.map { |x| x.photo_id }
		photo = Photo.where.not(photo_id: voted_photos).shuffle.first
		return photo
	end
end
