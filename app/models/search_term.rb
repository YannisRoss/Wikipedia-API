class SearchTerm < ApplicationRecord
    require './lib/assets/API_methods.rb'
    include APIMethods


    #after_commit :generate_entries


    validates :body, uniqueness: true
    
    belongs_to :user
    has_many :wiki_entries

    private
    def generate_entries
        retrieved_entries = search(self.body)
    end
end
