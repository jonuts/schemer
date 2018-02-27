RSpec.describe Schemer::Properties do
  it "has a collection of props" do
    expect(Schemer::Properties.new.props).to eql([])
  end
end
