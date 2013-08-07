require "gauntlt/version"

require 'rubygems'
require 'cucumber'
require 'gauntlt/attack'
require 'gauntlt/stepdef'

module Gauntlt
  CURRENT_DIR = if defined?(Pathname) # ruby 1.9
    Pathname.new(__FILE__).dirname.to_s
  else
    File.dirname(File.expand_path(__FILE__))
  end

  GAUNTLT_DIR = File.join(CURRENT_DIR, 'gauntlt')

  ATTACK_ADAPTERS_DIR = File.join(GAUNTLT_DIR, 'attack_adapters')

  ATTACK_ADAPTERS_GLOB_PATTERN = ATTACK_ADAPTERS_DIR + '/*.rb'
  
  ATTACK_ALIASES_DIR = File.join(GAUNTLT_DIR, 'attack_aliases')
  ATTACK_ALIASES_GLOB_PATTERN = ATTACK_ALIASES_DIR + '/*.json'

  class << self
    def attack_adapters
      Dir.glob(ATTACK_ADAPTERS_GLOB_PATTERN)
    end

    def attacks
      attack_adapters.map do |full_path|
        File.basename(full_path, '.rb')
      end.sort
    end

    def attack(path, tags=[], format="")
      Attack.new(path, tags, format).run
    end

    def stepdefs(path, tags=[])
      cuke_runtime = Gauntlt::Runtime.cuke_runtime(path, tags)
      Stepdef.sources(cuke_runtime)
    end
  end
end
