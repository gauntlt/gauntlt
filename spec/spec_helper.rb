$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'
Bundler.setup

require 'gauntlt'

require 'aruba/api'

Dir['./spec/support/**/*.rb'].map {|f| require f}

RSpec.configure do |c|
  c.include Aruba::Api
  c.include RSpecConstantsHelpers
  c.color = true
end