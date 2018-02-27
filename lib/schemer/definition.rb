module Schemer
  class Definition
    def initialize(name, type, opts={}, &block)
      @container = opts.delete(:container)
      @props     = Properties.new(container: self)
      @name      = name
      @type      = type

      instance_eval(&block) if block_given?
    end

    attr_reader :definitions, :props, :container, :name, :type

    def find_definition(name)
      @definitions[name] || @container&.definitions&.[](name)
    end

    def property(name, opts={})
      props.add_prop(name, opts)
    end

    def properties(&block)
      props.instance_eval(&block)
    end

    def definition(name, type=:object, &block)
      @definitions[name] = Definition.new(name, type, &block)
    end

    def items(name=nil, &block)
      @item_def =
        if name
          name
        else
          anon_definition(&block).name
        end
    end

    def to_hash
      {type: @type}.tap do |h|
        h[:required] = props.required_names if props.required_names.any?
        h[:properties] = props.to_hash if props.any?
        h[:items] = @definitions[@item_def].to_hash if @item_def
      end
    end

    private

    def anon_definition(&block)
      definition anonid
    end

    def anon_id
      @anonid = @anonid.to_i + 1
      :"anon#@anonid"
    end
  end
end
