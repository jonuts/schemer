# Schemer

Build and validate [JSON Schemas](http://json-schema.org/) with a
friendly ruby API. Very much not useable yet.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'schemer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install schemer

## Usage

### Building

Define your schemas:

```ruby
class AwesomeSchema < ::Schemer::Builder
  # You can create shared definitions to be reused across schemas:
  definition :address do
    property :street, type: :string, required: true
    property :street2, type: :string
    property :city, type: :string, required: true
    property :state, type: :string, required: true
  end

  # Properties can also be defined like so:
  definition :address do
    properties do
      # Define required properties in a required block:
      required do
        string :street
        string :city
      end

      # ... or inline
      string :state, required: true
      string :street2
    end
  end

  # Definitions can be attached to schemas using the :ref property:
  schema :person do
    properties do
      required do
        ref :address
        integer :age
        # Person schema will now have :address and :age properties, both
        # required. :address will be type :object with definition as
        # created above
      end
    end
  end
end
```

You can access any schemas defined in your builder class and render them
into a hash:

```ruby
AwesomeSchema.schemas.person.to_hash

# will render something like such:

{
  type: :object,
  required: [:address, :age],
  properties: {
    address: {
      type: :object,
      required: [:street, :city, :state],
      properties: {
        street: {type: :string},
        street2: {type: :string},
        city: {type: :string},
        state: {type: :string}
      }
    },
    age: {type: :integer}
  }
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/schemer.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
