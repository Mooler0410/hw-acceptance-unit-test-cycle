Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get 'same_director_movies/:title' => 'movies#search', as: 'same_directors'
end

