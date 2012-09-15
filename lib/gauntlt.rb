require "gauntlt/version"

require 'rubygems'
require 'cucumber'
require 'gauntlt/attack'

module Gauntlt
  CURRENT_DIR = if defined?(Pathname) # ruby 1.9
    Pathname.new(__FILE__).dirname.to_s
  else
    File.dirname(File.expand_path(__FILE__))
  end

  GAUNTLT_DIR = File.join(CURRENT_DIR, 'gauntlt')

  ATTACK_ADAPTERS_DIR = File.join(GAUNTLT_DIR, 'attack_adapters')

  ATTACK_ADAPTERS_GLOB_PATTERN = ATTACK_ADAPTERS_DIR + '/*.rb'

  class << self
    def attack_adapters
      Dir.glob(ATTACK_ADAPTERS_GLOB_PATTERN)
    end

    def attacks
      attack_adapters.map do |full_path|
        File.basename(full_path, '.rb')
      end.sort
    end

    def attack(path)
      Attack.new(path).run
    end
  end
end
