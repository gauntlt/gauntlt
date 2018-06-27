require "gauntlt/version"

require 'rubygems'
require 'cucumber'
require 'gauntlt/attack'
require 'gauntlt/stepdef'
require 'json'
require 'securerandom'
require 'fileutils'

module Gauntlt
  CURRENT_DIR = if defined?(Pathname) # ruby 1.9
    Pathname.new(__FILE__).dirname.to_s
  else
    File.dirname(File.expand_path(__FILE__))
  end
  #Read base file for version...
  GAUNTLT_BASE_DIR = "."
  GAUNTLT_FILE="gauntlt.json"
  data={}

  begin
    file = File.read(GAUNTLT_BASE_DIR+"/"+GAUNTLT_FILE)
    data = JSON.parse(file)
  rescue SystemCallError
    #Check for empty id
    print "Gauntlt file wasn't found. Creating...\n"
    if data["id"].to_s.empty?
      #Write an id to file
      data={
        "id"=>SecureRandom.uuid
      }
      dirname = File.dirname(GAUNTLT_BASE_DIR)
      unless File.directory?(GAUNTLT_BASE_DIR)
        FileUtils.mkdir_p(GAUNTLT_BASE_DIR)
      end
      File.open(GAUNTLT_BASE_DIR+"/"+GAUNTLT_FILE,"w") do |f|
        f.write(data.to_json)
      end
    end
  end

  print "Running gauntlt["+ data["id"]+"]"

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

    def attack(path, tags=[], format="", outfile="")
      Attack.new(path, tags, format, outfile).run
    end

    def stepdefs(path, tags=[])
      cuke_runtime = Gauntlt::Runtime.cuke_runtime(path, tags)
      Stepdef.sources(cuke_runtime)
    end
  end
end
