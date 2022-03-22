# frozen_string_literal: true

class CreateFavoritings < ActiveRecord::Migration[6.1]
  def change
    create_table :favoritings, id: false do |t|
      t.belongs_to :user
      t.belongs_to :wiki_entry
      t.timestamps
    end
  end
end
