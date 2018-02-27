RSpec.describe Schemer::Properties do
  it "has a collection of props" do
    expect(Schemer::Properties.new.all).to eql([])
  end
end
