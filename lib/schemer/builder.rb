module Schemer
  class Builder
    class <<self
      def inherited(klass)
        if root? || @parent
          klass.instance_variable_set(:@parent, self)
        else
          klass.root!
        end

        klass.instance_variable_set(:@definitions, {})
        klass.instance_variable_set(:@schemas, {})
        klass.instance_variable_set(:@props, Properties.new(container: self))
      end

      attr_reader :definitions, :schemas, :props, :container, :parent

      def full_props
        p = parent
        _props = props.to_a
        until p.root?
          _props += p.props.to_a
          p = p.parent
        end
        _props
      end

      def root!
        @root = true
      end

      def root?
        !!@root
      end

      def definition(name, opts={}, &block)
        opts[:type] = :object
        definitions[name] = build_definition(name, opts, &block)
      end

      def schema(name, opts={}, &block)
        schemas[name] = build_definition(name, opts, &block)
      end

      def property(name, opts={})
        raise DefinitionError, "Properties cannot be added to root schemas" if root?
        props.add opts[:type], name, opts
      end

      def properties(&block)
        raise DefinitionError, "Properties cannot be added to root schemas" if root?
        props.instance_eval(&block)
      end

      def find_definition(name)
        definitions[name] || container.definitions[name] || schemas[name] || container.schemas[name]
      end

      private

      def build_definition(name, opts, &block)
        Definition.new(name, opts.merge(container: self), &block)
      end
    end
  end
end
