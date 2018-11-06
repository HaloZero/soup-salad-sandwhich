Rails.application.routes.draw do
  	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	root 'vote#index'
 	resources :vote
 	get '/results', to: 'vote#results'

end
