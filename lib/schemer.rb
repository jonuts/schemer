require "schemer/version"
require "schemer/property"
require "schemer/properties"
require "schemer/definition"
require "schemer/builder"

module Schemer
  DefinitionError = Class.new(StandardError)
  InvalidPropertyTypeError = Class.new(DefinitionError)
end
