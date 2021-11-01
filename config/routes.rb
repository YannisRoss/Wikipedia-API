Rails.application.routes.draw do


  devise_for :users
  root to: "wiki_entries#index"


end
