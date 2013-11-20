$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'smod'
include Smod

RSpec.configure do |config|
  config.order = "random"

  #Use new expect syntax
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
