RSpec.describe Schemer::Property do
  describe "options" do
    it "requires a name" do
      expect {Schemer::Property.new}.to raise_error(ArgumentError)
    end

    it "requires a type" do
      expect {Schemer::Property.new(:foo)}.to raise_error(ArgumentError)
    end

    it "requires a valid type" do
      expect {Schemer::Property.new(:integer, :foo)}.to_not raise_error
      expect {Schemer::Property.new(:invalid, :foo)}.to raise_error(Schemer::InvalidPropertyTypeError)
    end
  end
end
