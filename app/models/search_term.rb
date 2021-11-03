class SearchTerm < ApplicationRecord
    require './lib/assets/API_methods.rb'
    include APIMethods


    validates :body, length: { minimum:1 }
    
    belongs_to :user
    has_many :wiki_entries


end
