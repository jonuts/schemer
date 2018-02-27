module Schemer
  class Definition
    def initialize(name, opts={})
      @name = name
      @opts = opts
      @props = Properties.new
    end

    attr_reader :props

    def property(name, opts={})
      props.add(name, opts)
    end

    def properties(&block)
      props.instance_eval(&block)
    end
  end
end
