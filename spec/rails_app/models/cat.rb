class Cat < ActiveRecord::Base

  enum gender: { male: 0, female: 1 }
  enum hair_color: { brown: 0, black: 1, blonde: 2 }

  validate_enum_attribute :gender, message: "Invalid gender value"
  validate_enum_attribute :hair_color, message: "ERROR: Must select a hair color from #{self.hair_colors.keys.join(", ")}"

end
