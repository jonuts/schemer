module Schemer
  class Properties
    include Enumerable

    def initialize(defaults={})
      @defaults = defaults
      @props = []
    end

    attr_reader :props

    def each(&block)
      props.each(&block)
    end

    def add(name, opts={})
      props << Property.new(name, @defaults.merge(opts))
    end

    # Create a Property collection and add them to collection with required: true
    def required(&block)
      Properties.new(required: true).instance_eval(&block).each do |p|
        props << p
      end
    end

    def string(field, opts={})
      add(field, opts.merge(type: :string))
    end

    def all
      props
    end

    def size
      props.size
    end
  end
end
