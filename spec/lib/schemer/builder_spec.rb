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

    describe "child schema" do
      let(:root) { Class.new(Schemer::Builder) }
      let(:child) { Class.new(root) }

      it "is not root" do
        expect(child).to_not be_root
      end
    end

    describe 'adding definitions' do
      let(:schema) { Class.new(Schemer::Builder) }

      context 'blank definition' do
        it "adds the definition to the collection" do
          expect { schema.definition(:foo) {} }.to change {
            schema.definitions.size
          }.from(0).to(1)
        end

        it "stores a Definition" do
          schema.definition(:foo) {}
          expect(schema.definitions.first.class).to eql(Schemer::Definition)
        end
      end
    end

    describe 'adding schemas' do
      let(:schema) { Class.new(Schemer::Builder) }

      context 'blank schema' do
        it "adds the schema to the collection" do
          expect { schema.schema(:foo) {} }.to change {
            schema.schemas.size
          }.from(0).to(1)
        end

        it "stores a Definition" do
          schema.schema(:foo) {}
          expect(schema.schemas.first.class).to eql(Schemer::Definition)
        end
      end
    end
  end
end

