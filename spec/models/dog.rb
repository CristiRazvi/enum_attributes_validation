# dogs are friendly

describe Dog do
  I18n.config.available_locales = [:en, :return_default_message]

  before(:each) do
    I18n.locale = :en
  end

  it "passes when enum values are valid" do
    dog = Dog.new(hair_color: :brown, gender: :female)

    expect(dog.save).to be true
  end

  it "saves nil when values are not set" do
    dog = Dog.new

    expect(dog.save).to be true
    expect(dog.gender).to be nil
    expect(dog.hair_color).to be nil
  end

  it "fails when values are nil" do
    dog = Dog.new(hair_color: nil, gender: nil)

    expect(dog.save).to be true
    expect(dog.gender).to be nil
    expect(dog.hair_color).to be nil
  end

  it "fails with invalid hair_color ad default message" do
    I18n.locale = :return_default_message
    dog = Dog.new(hair_color: :blue)

    expect(dog.save).to be false
    expect(dog.errors.full_messages).to include "Hair color value provided (blue) is invalid"
  end

  it "fails with invalid gender" do
    dog = Dog.new(gender: :invalid_gender)

    expect(dog.save).to be false
    expect(dog.errors.full_messages).to include "Gender value provided (invalid_gender) is invalid"
  end

  it "returns locale error message" do
    I18n.backend.store_translations(:en, {
      activerecord: {
        attributes: {
          dog: {
            gender: "Gender",
            hair_color: "Hair color"
          }
        },

        errors: {
          models: {
            dog: {
              attributes: {
                hair_color: {
                  invalid_enum: "can't be %{value}. Valid values are: %{valid_values}"
                }
              }
            }
          }
        }
      }
    })

    hair_color = :blue
    dog = Dog.new(hair_color: hair_color)

    expect(dog.save).to be false
    expect(dog.errors.messages[:hair_color]).to include I18n.t("activerecord.errors.models.dog.attributes.hair_color.invalid_enum", value: hair_color, valid_values: Dog.hair_colors.keys.sort.join(', '))
  end

  it "changes enum attribute valuse using bang! methods" do
    dog = Dog.create

    expect(dog.happy!).to be true
    expect(dog.status).to eq "happy"
    expect(dog.sad!).to be true
    expect(dog.status).to eq "sad"
  end

end
