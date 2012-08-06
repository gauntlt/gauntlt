$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'
Bundler.setup

require 'gauntlt'

require 'aruba/api'

RSpec.configure do |c|
  c.include Aruba::Api
  c.color = true
end