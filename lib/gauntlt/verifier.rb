require 'cucumber'
require 'cucumber/cli/main'

class Gauntlt
  class Verifier
    def initialize(name, opts={})
      @name = name
      @opts = opts
      @feature_file = File.join(base_dir, "cucumber", "#{@name}.feature")
    end
    
    def base_dir 
      File.expand_path( File.dirname(__FILE__) )
    end
    
    def cuke_dir
      File.join(base_dir, "cucumber")
    end

    def run   
      Cucumber::Cli::Main.execute([@feature_file, '--require', cuke_dir])
    end
  end
end