class SearchTerm < ApplicationRecord

    validates :body, uniqueness: true

    belongs_to :user
    
    has_many :wiki_entries
end
