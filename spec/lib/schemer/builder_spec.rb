RSpec.describe Schemer::Builder do
  describe "building" do
    let(:root) { Class.new(Schemer::Builder) }
    let(:child) { Class.new(root) }

    describe "root schema" do
      let(:schema) do
        Class.new(Schemer::Builder)
      end

      it "has empty definitions" do
        expect(schema.definitions).to eql({})
      end

      it "has empty schemas" do
        expect(schema.schemas).to eql({})
      end

      it "is root" do
        expect(schema).to be_root
      end
    end

    describe "child schema" do
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

        context do
          before do
            schema.definition(:foo, opts) {}
          end

          let(:opts) { {} }

          subject { schema.definitions[:foo] }

          it "stores a Definition" do
            expect(subject.class).to eql(Schemer::Definition)
          end

          it 'sets definition container' do
            expect(subject.container).to eql(schema)
          end

          it 'sets type to :object' do
            expect(subject.type).to eql(:object)
          end

          context 'when provided with different type' do
            let(:opts) { {type: :array} }
            it 'overrides type to :object' do
              expect(subject.type).to eql(:object)
            end
          end
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

        context do
          before do
            schema.schema(:foo, opts) {}
          end

          let(:opts) { {} }

          subject { schema.schemas[:foo] }

          it "stores a Definition" do
            expect(subject.class).to eql(Schemer::Definition)
          end

          it 'sets schema container' do
            expect(subject.container).to eql(schema)
          end

          it 'sets type to :object' do
            expect(subject.type).to eql(:object)
          end

          context 'when provided with different type' do
            let(:opts) { {type: :array} }
            it 'allows different type' do
              expect(subject.type).to eql(:array)
            end
          end
        end
      end
    end

    describe 'adding properties' do
      context 'when root schema' do
        it 'is not allowed' do
          expect { root.property(:foo, type: :string) }.to raise_error(Schemer::DefinitionError)
        end
      end

      context 'when child' do
        before do
          child.property :foo, type: :string
        end

        it 'adds the property' do
          expect(child.props.first.class).to eql(Schemer::Property)
        end
      end
    end
  end
end

