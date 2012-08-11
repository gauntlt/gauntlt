require 'cucumber'
require 'cucumber/cli/main'

module Gauntlt
  class Attack
    class NotFound < Exception; end

    attr_accessor :name, :opts, :attack_file

    def initialize(name, opts={})
      if opts[:attack_file] && File.exists?( opts[:attack_file] )
        self.name = name
        self.opts = opts
        self.attack_file = opts[:attack_file]
      else
        raise NotFound.new("No '#{opts[:attack_file]}' attack found")
      end
    end

    def base_dir
      File.expand_path( File.dirname(__FILE__) )
    end

    def attacks_dir
      File.join(base_dir, "attack_adapters")
    end

    def run
      failed = Cucumber::Cli::Main.execute([self.attack_file, '--strict', '--require', self.attacks_dir])

      raise "Attack failed!" if failed
    end
  end
end