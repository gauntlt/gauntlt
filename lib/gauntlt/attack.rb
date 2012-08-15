require 'cucumber'
require 'cucumber/cli/main'

module Gauntlt
  class Attack
    class NotFound < Exception; end
    class ExecutionFailed < Exception; end

    attr_accessor :name, :opts, :attack_files

    def initialize(name, opts={})
      missing_attacks = missing_attacks(opts[:attack_files])

      if opts[:attack_files] && missing_attacks.empty?
        self.opts = opts
        self.name = name
        self.attack_files = opts[:attack_files]
      else
        raise NotFound.new("No '#{missing_attacks.join(', ')}' attack found")
      end
    end

    def base_dir
      File.expand_path( File.dirname(__FILE__) )
    end

    def attacks_dir
      File.join(base_dir, "attack_adapters")
    end

    def run
      cucumber_options = self.attack_files + ['--strict', '--require', self.attacks_dir]
      cli = Cucumber::Cli::Main.new(cucumber_options)

      if cli.execute! # cucumber failed, returning true
        raise ExecutionFailed.new("Bad or undefined attack!")
      else            # cucumber executed successfully, returning false
        true
      end
    end

    private

    def missing_attacks attacks
      attacks.select { |a| !File.exists?(a) }
    end
  end
end
