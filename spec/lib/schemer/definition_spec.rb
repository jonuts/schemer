RSpec.describe Schemer::Definition do
  it "requires a name" do
    expect {described_class.new}.to raise_error(ArgumentError)
  end

  it "has an empty properties collection" do
    expect(described_class.new(:foo).collection.class).to eql(Schemer::Properties)
  end
end
