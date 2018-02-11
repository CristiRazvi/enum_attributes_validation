require 'byebug'
require 'enum_attributes_validation'

require 'bundler/setup'
Bundler.setup(:default, :development)

require 'active_record'
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: "enum_attributes_validation_test_db"

schema = File.expand_path("../rails_app/db/schema.rb", __FILE__)
load schema

rails_models = Dir[File.expand_path("../rails_app/models/*.rb", __FILE__)]
rails_models.each do |model|
  require model
end
