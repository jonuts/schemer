RSpec.describe Schemer::Builder do
  describe "building" do
    describe "root schema" do
      let(:schema) do
        Class.new(Schemer::Builder)
      end

      it "has empty definitions" do
        expect(schema.definitions).to eql([])
      end

      it "has empty schemas" do
        expect(schema.schemas).to eql([])
      end

      it "is root" do
        expect(schema).to be_root
      end
    end
  end
end

