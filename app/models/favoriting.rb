class Favoriting < ApplicationRecord
  belongs_to :user
  belongs_to :wiki_entry
end
