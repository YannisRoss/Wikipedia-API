require 'rails_helper'

RSpec.describe Favoriting, type: :model do
  it "can't be instantiated on its own" do
    expect { Favoriting.create!}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "cannot exist without a user" do
    invalid_favoriting = Favoriting.new
    expect(invalid_favoriting.valid?).to be(false)
  end


end
