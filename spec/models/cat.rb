# cats are evil

describe Cat do

  it "returns custom messages" do
    cat = Cat.new(hair_color: :wrong_value, gender: :wrong_value)
    cat.save

    expect(cat.errors.messages[:base]).to include "Invalid gender value"
    expect(cat.errors.messages[:base]).to include "ERROR: Must select a hair color from #{Cat.hair_colors.keys.join(", ")}"
  end

end
