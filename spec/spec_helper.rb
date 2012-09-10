$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'
Bundler.setup

require 'spork'

Spork.prefork do
  require 'aruba/api'
  require 'rspec'
  RSpec.configure do |c|
    c.include Aruba::Api
    c.color = true
  end  
end

Spork.each_run do
  require 'gauntlt'
end
