Rails.application.routes.draw do

    get 'favoritings/create'
    get 'favoritings/destroy'
    get 'search_terms/destroy'

    devise_for :users

    root to: 'wiki_entries#welcome'
  scope "/:locale" do
    resources :wiki_entries
    resources :favoritings

    resources :search_terms
  end
end
