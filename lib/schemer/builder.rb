module Schemer
  class Builder
    class <<self
      def inherited(klass)
        if root?
          klass.instance_variable_set(:@container, self)
        else
          klass.root!
        end

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
        opts[:type] = :object
        definitions << build_definition(name, opts, &block)
      end

      def schema(name, opts={}, &block)
        schemas << build_definition(name, opts, &block)
      end

      def property(name, opts={})
        raise DefinitionError, "Properties cannot be added to root schemas" if root?
        props.add name, opts
      end

      private

      def build_definition(name, opts, &block)
        Definition.new(name, opts.merge(container: self), &block)
      end
    end
  end
end
