require "json"

module Gauntlt
  module Support
    module AttackStepHelper

      def gauntlt_attack_steps
        @gauntlt_attack_steps ||= {}
      end
      
      def load_attack(step)
        @attack_steps = import_attack_steps
         @attack_steps[step] || raise("Unknown attack step #{step}")
      end

      def import_attack_steps
         @imported_attack_steps = Hash.new
         attack_steps_json = Dir.glob(ATTACK_STEPS_GLOB_PATTERN)
         attack_steps_json.each do |file|
           @imported_attack_steps.merge!(JSON.load(File.open(file)))
         end
         @imported_attack_steps
      end

    end
  end
end

World(Gauntlt::Support::AttackStepHelper)

