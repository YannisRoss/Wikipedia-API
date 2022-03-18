# frozen_string_literal: true

class AddIdToFavoritings < ActiveRecord::Migration[6.1]
  def change
    add_column :favoritings, :id, :primary_key
  end
end
