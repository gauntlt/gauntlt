require 'gauntlt/runtime'

module Gauntlt
  class Stepdef
    class << self
      def find(cuke_runtime)
        cuke_runtime.send(:load_step_definitions)
        cuke_runtime.instance_variable_get(:@support_code).step_definitions
      end

      def sources(cuke_runtime)
        returner = {:aruba => [], :gauntlt => []}

        self.find(cuke_runtime).each do |step_definition|
          if step_definition.file =~ /aruba/
            returner[:aruba] << step_definition.regexp_source
          else
            returner[:gauntlt] << step_definition.regexp_source
          end
        end

        returner
      end
    end
  end
end
