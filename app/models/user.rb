class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favoritings
  has_many :favorite_entries, through: :favoritings, source: :wiki_entry
  has_many :search_terms

  def activity_factor
    weekly_activity = search_terms.where('created_at >= ?',
                                         1.week.ago.utc).length + favoritings.where('created_at >= ?',
                                                                                    1.week.ago.utc).length
    total_activity = search_terms.length + favorite_entries.length

    if total_activity.nonzero?
      weekly_activity / total_activity
    else
      0
    end
  end
end
