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

  ATTACKS_DIR = File.join(GAUNTLT_DIR, 'attack_adapters')

  ATTACK_GLOB_PATTERN = ATTACKS_DIR + '/*.rb'

  class << self
    def attack_files
      Dir.glob(ATTACK_GLOB_PATTERN)
    end

    def attacks
      attack_files.map do |full_path|
        File.basename(full_path, '.rb')
      end.sort
    end

    def has_attack?(name)
      attacks.include?(name)
    end

    def attack(name, options={})
      Attack.new(name, options).run
    end
  end
end
