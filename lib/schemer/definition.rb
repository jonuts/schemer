module Schemer
  class Definition
    def initialize(name, opts={}, &block)
      @name = name
      @container = opts.delete(:container)
      @type = opts.delete(:type) || :object
      @opts = opts
      @props = Properties.new

      instance_eval(&block) if block_given?
    end

    attr_reader :props, :container, :name, :type

    def property(name, opts={})
      props.add(name, opts)
    end

    def properties(&block)
      props.instance_eval(&block)
    end
  end
end
