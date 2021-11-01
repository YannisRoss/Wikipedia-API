class WikiEntry < ApplicationRecord

    belongs_to :search_term
    has_and_belongs_to_many :favoritees, foreign_key: "wiki_entry_id", class_name: "User"
end
