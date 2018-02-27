module Schemer
  class Builder
    class <<self
      def inherited(klass)
        klass.root! unless root?
        klass.instance_variable_set(:@definitions, [])
      end

      attr_reader :definitions

      def root!
        @root = true
      end

      def root?
        !!@root
      end

      def schemas
        []
      end

      def definition(name, opts={}, &block)
        definitions << Definition.new(name, opts, &block)
      end
    end
  end
end
