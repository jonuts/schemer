module Schemer
  class Properties
    include Enumerable

    def initialize(defaults={})
      @container = defaults.delete(:container)
      @defaults = defaults
      @props = []
    end

    attr_reader :props

    def each(&block)
      props.each(&block)
    end

    def add(type, name, opts={})
      opts[:type] = type
      props << Property.new(name, @defaults.merge(opts))
    end

    # Create a Property collection and add them to collection with required: true
    def required(&block)
      Properties.new(required: true, container: @container).instance_eval(&block).each do |p|
        props << p
      end
    end

    def string(field, opts={})
      add(:string, field, opts)
    end

    def ref(field, definition=nil)
      add(:ref, field, definition: find_definition(definition || field))
    end

    def all
      props
    end

    def size
      props.size
    end

    def find_definition(definition)
      @container.find_definition(definition)
    end
  end
end
