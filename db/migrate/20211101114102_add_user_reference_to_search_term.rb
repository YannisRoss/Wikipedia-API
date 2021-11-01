class AddUserReferenceToSearchTerm < ActiveRecord::Migration[6.1]
  def change

    add_reference :search_terms, :user, foreign_key: true

  end
end
