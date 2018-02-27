module Schemer
  class Property
    VALID_TYPES = %i(string integer ref)

    def initialize(type, field, opts={})
      @type = type
      @name = field
      @required = opts.delete(:required)
      @container = opts.delete(:container)
      @definition = opts.delete(:definition)
      @opts = opts
      assert_valid_type!
    end

    attr_reader :name, :type

    def to_hash
      parsed_opts.tap {|o| o.merge!(@definition.to_hash) if @definition }
    end

    def parsed_opts
      opts = @opts.dup
      if ref?
        opts[:type] = :object
      elsif opts[:enum]
        opts.delete(:type)
      else
        opts[:type] = @type
      end

      opts
    end

    def required?
      !!@required
    end

    def ref?
      @type == :ref
    end

    def add_definition(&block)
      @definition = Definition.new :anon, :object, &block
    end

    private

    def assert_valid_type!
      return true if VALID_TYPES.include?(@type)
      raise InvalidPropertyTypeError, "#@type not in #{VALID_TYPES.inspect}"
    end
  end
end
