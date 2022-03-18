# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Favoriting, type: :model do
  it "can't be instantiated on its own" do
    expect { Favoriting.create! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'cannot exist without a user and wiki entry' do
    invalid_favoriting = Favoriting.new
    expect(invalid_favoriting.valid?).to be(false)
  end

  it 'can exist with a user' do
    user = User.new(email: '9000@9000.com', password: 'abcdef')
    user.save

    term = SearchTerm.new(body: 'body', user_id: 1)
    term.save
    entry = WikiEntry.new(search_term_id: 1, title: 'title', pageid: 1, wordcount: 1, snippet: 'snippet',
                          fullurl: 'fullurl')
    entry.save

    valid_favoriting = Favoriting.new(user_id: 1, wiki_entry_id: 1)
    puts valid_favoriting.valid?
    puts valid_favoriting.errors.full_messages
    expect(valid_favoriting.valid?).to be(true)
  end
end
