require 'cucumber'

module Gauntlt
  class Stepdef
    # Force a dry-run and report just the step names
    ARGS = ["-d", "-f", "stepdefs"]

    class << self
      def definitions
        new.definitions
      end
    end

    def initialize
      config = Cucumber::Cli::Configuration.new(STDOUT, STDERR)
      config.parse!(ARGS)
      runtime = Cucumber::Runtime.new(config)
      @steps = get_steps(runtime)
    end

    def get_steps(runtime)
      runtime.send(:load_step_definitions)
      runtime.instance_variable_get("@support_code").step_definitions
    end

    def definitions
      stepdefs = []
      @steps.sort{|a,b| a.to_hash['source'] <=> a.to_hash['source']}.each do |stepdef|
        stepdef_hash = stepdef.to_hash
        stepdef_hash['kind'] = if stepdef.file =~ /aruba/ # stepdef.file_colon_line
                                 "aruba"
                               else
                                 "gauntlt"
                               end
        stepdefs << stepdef_hash
      end
      stepdefs
    end
  end
end
