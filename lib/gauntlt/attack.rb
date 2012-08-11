require 'cucumber'
require 'cucumber/cli/main'

module Gauntlt
  class Attack
    class NotFound < Exception; end
    class ExecutionFailed < Exception; end

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
      @out = StringIO.new ""

      cli = Cucumber::Cli::Main.new([self.attack_file, '--strict', '--require', self.attacks_dir], @out)

      if cli.execute! # cucumber failed, returning true
        raise ExecutionFailed.new("Bad or undefined attack!")
      else            # cucumber executed successfully, returning false
        @out.string
      end
    end
  end
end