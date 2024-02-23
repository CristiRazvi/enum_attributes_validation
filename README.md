This is supported in Rails 7.1+ 

https://github.com/rails/rails/pull/49100

Also note:

```
enum something: { ... }
```

is now deprecated: https://github.com/rails/rails/pull/50987

and
 
```
enum :something, { ... }, validate: true
```

should be used
<br/>
<br/>
---
<br/>
<br/>
<br/>



# EnumAttributesValidation

Enum Attributes Validation provides validation functionality for enum attributes in models. It validates **inclusion** for the specified enum keys. If values are **nil** the record is saved.

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

Use built in method to specify which enum attributes you want to validate.

```ruby
class Dog < ApplicationRecord
  enum gender: { male: 0, female: 1 }
  enum hair_color: { brown: 0, black: 1, blonde: 2 }

  validate_enum_attributes :gender, :hair_color
end

dog = Dog.new(hair_color: :brown, gender: :female)
dog.save
# => <Dog gender: "female", hair_color: "brown" >

dog = Dog.new
dog.save
# => <Dog gender: nil, hair_color: nil >

dog = Dog.new(hair_color: nil, gender: nil)
dog.save
# => <Dog gender: nil, hair_color: nil >
```

Or use the singular method.

```ruby
class Dog < ApplicationRecord
  enum gender: { male: 0, female: 1 }
  enum hair_color: { brown: 0, black: 1, blonde: 2 }

  validate_enum_attribute :gender
end
```


### Custom error messages

To show a custom error message:

```ruby
class Dog < ApplicationRecord
  enum gender: { male: 0, female: 1 }

  validate_enum_attribute :gender, message: "Some string msg..."
end
```

### Translations

To use translations you need to update your locale file as follows

```yml
en:
  activerecord:
    errors:
      models:
        #your_model_name#:
          attributes:
            #your_attribute_name#::
              invalid_enum: "can't be %{value}. Valid values are: %{valid_values}"

```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CristiRazvi/enum_attributes_validation.

## License

MIT License.
