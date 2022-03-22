# frozen_string_literal: true

class CreateSearchTerms < ActiveRecord::Migration[6.1]
  def change
    create_table :search_terms, &:timestamps
  end
end
