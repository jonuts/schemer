RSpec.describe Schemer::Definition do
  it "requires a name" do
    expect {described_class.new}.to raise_error(ArgumentError)
  end

  it "has an empty properties collection" do
    expect(described_class.new(:foo, :object).props.class).to eql(Schemer::Properties)
  end

  describe "adding properties" do
    let(:definition) { Schemer::Definition.new(:address, :object) }

    shared_examples_for "added props" do
      it "has all the props" do
        expect(definition.props.size).to eql(4)
      end

      it "adds the correct types" do
        expect(definition.props.map(&:type)).to eql(Array.new(4).map {:string})
      end

      it "marks required" do
        expect(definition.props.select(&:required?).size).to eql(3)
      end
    end

    context "with #property" do
      before do
        definition.property :street, type: :string, required: true
        definition.property :street2, type: :string
        definition.property :city, type: :string, required: true
        definition.property :state, type: :string, required: true
      end

      it_behaves_like "added props"
    end

    context "with #properties block" do
      before do
        definition.properties do
          string :street, required: true
          string :street2
          string :city, required: true
          string :state, required: true
        end
      end

      it_behaves_like "added props"
    end

    context "with #properties + #required" do
      before do
        definition.properties do
          required do
            string :street
            string :city
            string :state
          end

          string :street2
        end
      end

      it_behaves_like "added props"
    end
  end
end
