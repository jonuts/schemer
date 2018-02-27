RSpec.describe Schemer::Property do
  describe "options" do
    it "requires a name" do
      expect {Schemer::Property.new}.to raise_error(ArgumentError)
    end

    it "requires a type" do
      expect {Schemer::Property.new(:foo)}.to raise_error(ArgumentError)
    end

    it "requieres a valid type" do
      expect {Schemer::Property.new(:foo, type: :integer)}.to_not raise_error
      expect {Schemer::Property.new(:foo, type: :invalid)}.to raise_error(Schemer::InvalidPropertyTypeError)
    end
  end
end
