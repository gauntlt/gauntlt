require 'cucumber'
require 'cucumber/cli/main'

module Gauntlt
  class Attack
    class NotFound < Exception; end

    attr_accessor :name, :opts, :attack_file

    def initialize(name, opts={})
      if File.exists?( attack_file = attack_file_for(name) )
        self.name = name
        self.opts = opts
        self.attack_file = attack_file
      else
        raise NotFound.new("No '#{name}' attack found")
      end
    end

    def attack_file_for(some_name)
      File.join(attacks_dir, "#{some_name}.attack")
    end

    def base_dir
      File.expand_path( File.dirname(__FILE__) )
    end

    def attacks_dir
      File.join(base_dir, "attacks")
    end

    def run
      Cucumber::Cli::Main.execute([self.attack_file, '--require', self.attacks_dir])
    end
  end
end