require 'rails_helper'

RSpec.describe SearchTerm, type: :model do
  it "cannot be blank" do
    expect { SearchTerm.create!}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "cannot be an empty string" do
    empty_string = SearchTerm.new(body: "")
    expect(empty_string.valid?).to be(false)
  end

  it "cannot be assigned to a non-existing user" do
    term = SearchTerm.new(body: 'body', user_id: 1)

    expect(term.valid?).to be(false)
  end
end 
