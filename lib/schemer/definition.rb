module Schemer
  class Definition
    def initialize(name, opts={})
      @name = name
      @opts = opts
      @collection = Properties.new
    end

    attr_reader :collection
  end
end
