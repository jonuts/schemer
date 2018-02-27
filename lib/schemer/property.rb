module Schemer
  class Property
    VALID_TYPES = %i(string integer)

    def initialize(name, opts={})
      @name = name
      @opts = opts
      @required = @opts.delete(:required)
      assert_valid_type!
    end

    def required?
      !!@required
    end

    def type
      @opts[:type]
    end

    private

    def assert_valid_type!
      return true if VALID_TYPES.include?(@opts[:type])
      raise InvalidPropertyTypeError, "#{@opts[:type]} not in #{VALID_TYPES.inspect}"
    end
  end
end
