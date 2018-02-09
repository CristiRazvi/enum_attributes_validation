# EnumAttributesValidation

Enum Attributes Validation provides validation functionality for enum attributes in models.

## Installation

Add to Gemfile:

```ruby
gem 'enum_attributes_validation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enum_attributes_validation

## Usage

Use built in method to specify which enum attributes you want to validate with inclusion.

```ruby
class Comment < ApplicationRecord
  enum gender: { male: 0, female: 1 }

  validate_enum_attributes :gender
end
```

To show a custom error message:

```ruby
class Comment < ApplicationRecord
  enum gender: { male: 0, female: 1 }

  validate_enum_attributes :gender, message: "some string msg..."
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CristiRazvi/enum_attributes_validation.

## License

MIT License.
