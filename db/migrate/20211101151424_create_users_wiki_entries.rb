class CreateUsersWikiEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :users_wiki_entries, id: false do |t|
      t.belongs_to :user
      t.belongs_to :wiki_entry
      t.timestamps
    end
  end
end
