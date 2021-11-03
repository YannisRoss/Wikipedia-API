require 'rails_helper'

RSpec.describe SearchTerm, type: :model do
  it "cannot be blank" do
    expect { SearchTerm.create!}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "cannot be an empty string" do
    empty_string = SearchTerm.new(body: "")
    expect(empty_string.valid?).to be(false)
  end

end 
