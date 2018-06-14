ActiveRecord::Schema.define(version: 0) do
  self.verbose = false

  create_table :dogs, :force => true do |t|
    t.integer :gender
    t.integer :hair_color
    t.integer :status

    t.timestamps
  end

  create_table :cats, :force => true do |t|
    t.integer :gender
    t.integer :hair_color

    t.timestamps
  end

end
