class WikiEntry < ApplicationRecord

    belongs_to :search_term
    has_many :favoritees, through: :favoritings, source: :user
end
