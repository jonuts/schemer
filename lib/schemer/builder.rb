module Schemer
  class Builder
    class <<self
      def inherited(klass)
        klass.root! unless root?
        klass.instance_variable_set(:@definitions, [])
        klass.instance_variable_set(:@schemas, [])
      end

      attr_reader :definitions, :schemas

      def root!
        @root = true
      end

      def root?
        !!@root
      end

      def definition(name, opts={}, &block)
        definitions << Definition.new(name, opts, &block)
      end

      def schema(name, opts={}, &block)
        schemas << Definition.new(name, opts, &block)
      end
    end
  end
end
