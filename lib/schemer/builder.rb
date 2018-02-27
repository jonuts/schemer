module Schemer
  class Builder
    class <<self
      def inherited(klass)
        klass.root! unless root?
        klass.instance_variable_set(:@definitions, [])
        klass.instance_variable_set(:@schemas, [])
        klass.instance_variable_set(:@props, Properties.new)
      end

      attr_reader :definitions, :schemas, :props

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

      def property(name, opts={})
        raise DefinitionError, "Properties cannot be added to root schemas" if root?
        props.add name, opts
      end
    end
  end
end
