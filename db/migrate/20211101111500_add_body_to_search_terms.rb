# frozen_string_literal: true

class AddBodyToSearchTerms < ActiveRecord::Migration[6.1]
  def change
    add_column :search_terms, :body, :string
  end
end
