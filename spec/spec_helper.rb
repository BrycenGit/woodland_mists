require 'rspec'
require 'pg'
require 'stage'
require 'artist'
require 'pry'
require('dotenv/load')

DB = PG.connect({:dbname => 'woodland_mists_test', :password => ENV['PG_PASS']})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stages *;")
    DB.exec("DELETE FROM artists *;")
  end
end
