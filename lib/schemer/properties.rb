module Schemer
  class Properties
    include Enumerable

    def initialize(opts={})
      @collection = []
    end

    def each(&block)
      @collection.each(&block)
    end

    def add(name, opts={})
      @collection << Property.new(name, opts)
    end

    def all
      @collection
    end
  end
end
