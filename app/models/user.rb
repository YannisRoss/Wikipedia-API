class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_and_belongs_to_many :favorite_entries, foreign_key: "user_id", class_name: "WikiEntry"
         has_many :search_terms
end
