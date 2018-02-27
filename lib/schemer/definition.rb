module Schemer
  class Definition
    def initialize(name, opts={}, &block)
      @name = name
      @container = opts.delete(:container)
      @type = opts.delete(:type) || :object
      @opts = opts
      @props = Properties.new(container: self)

      instance_eval(&block) if block_given?
    end

    attr_reader :props, :container, :name, :type

    def property(name, opts={})
      props.add(name, opts)
    end

    def properties(&block)
      props.instance_eval(&block)
    end

    def find_definition(name)
      @container.find_definition(name)
    end
  end
end
