module Schemer
  class Properties
    include Enumerable

    def initialize(defaults={})
      @container = defaults.delete(:container)
      @defaults = defaults
      @props = []
    end

    attr_reader :props

    def required_names
      props.select(&:required?).map(&:name)
    end

    def each(&block)
      props.each(&block)
    end

    def properties(&block)
      instance_eval(&block)
    end

    def string(field, opts={})
      add prop(:string, field, opts)
    end

    def integer(field, opts={})
      add prop(:array, field, opts)
    end

    def array(field, opts={})
      add prop(:array, field, opts)
    end

    def object(field, opts={}, &block)
      add prop(:object, field, opts, &block)
    end

    def ref(field, definition=nil)
      add prop(:ref, field, definition: find_definition(definition || field) )
    end

    def required(&block)
      Properties.new(required: true, container: @container).instance_eval(&block).each do |p|
        props << p
      end
    end

    def to_hash
      Hash[map{|p| [p.name, p.to_hash]}]
    end

    def size
      props.size
    end

    def add_prop(name, opts={})
      add prop(opts[:type], name, opts)
    end

    private

    def find_definition(name)
      @container.find_definition(name)
    end

    def add(p)
      tap { props << p }
    end

    def prop(type, field, opts, &block)
      Property.new(type, field, @defaults.merge(opts)).tap do |p|
        p.add_definition(&block) if block_given?
      end
    end
  end
end
