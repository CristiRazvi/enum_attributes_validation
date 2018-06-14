class Dog < ActiveRecord::Base

  enum gender: { male: 0, female: 1 }
  enum hair_color: { brown: 0, black: 1, blonde: 2 }
  enum status: [ :happy, :sad ]

  validate_enum_attributes :gender, :hair_color

end
