class AddAttributesToWikiEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :wiki_entries, :title, :string
    add_column :wiki_entries, :pageid, :integer
    add_column :wiki_entries, :wordcount, :integer
    add_column :wiki_entries, :snippet, :string
    add_column :wiki_entries, :fullurl, :string
  end
end
