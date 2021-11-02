Rails.application.routes.draw do


  get 'favoritings/create'
  get 'favoritings/destroy'
  devise_for :users


  root to: "wiki_entries#welcome"

  resources :wiki_entries
  resources :favoritings
  
  resources :search_terms
end
