$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'smod'
require 'factory_girl'
include Smod

RSpec.configure do |config|
  config.order = "random"

  #Setup factorygirl
  config.include FactoryGirl::Syntax::Methods
   
  #Use new expect syntax
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
