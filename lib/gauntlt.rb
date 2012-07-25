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

  CUKE_DIR = File.join(GAUNTLT_DIR, 'cucumber')

  FEATURE_GLOB_PATTERN = CUKE_DIR + '/**/*.feature'

  class << self
    def feature_files
      Dir.glob(FEATURE_GLOB_PATTERN)
    end

    def attacks
      feature_files.map do |full_path|
        File.basename(full_path, '.feature')
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
