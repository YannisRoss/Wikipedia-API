Rails.application.routes.draw do


  devise_for :users


  root to: "wiki_entries#index"

  resources :wiki_entries

  resources :search_terms
end
