# frozen_string_literal: true

class CreateWikiEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :wiki_entries, &:timestamps
  end
end
