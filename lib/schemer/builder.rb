require 'ostruct'

module Schemer
  class Builder
    class <<self
      def inherited(klass)
        klass.instance_variable_set(:@definitions, OpenStruct.new)
        klass.instance_variable_set(:@schemas, OpenStruct.new)
      end

      def schema(name, type=:object, &block)
        schemas[name] = Definition.new(name, type, &block)
      end

      def definition(name, &block)
        definitions[name] = Definition.new(name, :object, &block)
      end

      attr_reader :schemas, :definitions
    end
  end
end
