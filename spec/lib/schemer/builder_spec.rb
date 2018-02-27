RSpec.describe Schemer::Builder do
  describe "building" do
    let(:schema) do
      Class.new(Schemer::Builder)
    end

    it "has empty definitions" do
      expect(schema.definitions).to eql(OpenStruct.new)
    end

    it "has empty schemas" do
      expect(schema.schemas).to eql(OpenStruct.new)
    end

    describe 'adding definitions' do
      context 'blank definition' do
        before do
          schema.definition(:foo) {}
        end

        subject { schema.definitions.foo }

        it "stores a Definition" do
          expect(subject.class).to eql(Schemer::Definition)
        end

        it 'sets type to :object' do
          expect(subject.type).to eql(:object)
        end
      end
    end

    describe 'adding schemas' do
      context 'blank schema' do
        before do
          schema.schema(:foo, type) {}
        end

        let(:type) { :object }

        subject { schema.schemas.foo }

        it "stores a Definition" do
          expect(subject.class).to eql(Schemer::Definition)
        end

        it 'sets type to :object' do
          expect(subject.type).to eql(:object)
        end

        context 'when provided with different type' do
          let(:type) { :array }
          it 'allows different type' do
            expect(subject.type).to eql(:array)
          end
        end
      end
    end

  end

  describe 'simple schema'
end

