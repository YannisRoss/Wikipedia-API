class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :favoritings
         has_many :favorite_entries, through: :favoritings, source: :wiki_entry
         has_many :search_terms
end
