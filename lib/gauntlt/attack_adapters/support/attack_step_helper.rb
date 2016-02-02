require "json"

module Gauntlt
  module Support
    module AttackAliasHelper

      def gauntlt_attack_aliases
        @gauntlt_attack_aliases ||= {}
      end
      
      def load_attack_alias(alias_name, *version)
        @attack_steps = import_attack_aliases
        if version.length > 0
            alias_name << "-"
            alias_name << version[0]
        end
        @attack_steps[alias_name] || raise("Unknown attack alias #{alias_name}, try gauntlt --list_attack_aliases")
      end

      def import_attack_aliases
         @imported_attack_aliases = Hash.new
         attack_aliases_json = Dir.glob(ATTACK_ALIASES_GLOB_PATTERN)
         attack_aliases_json.each do |file|
         @imported_attack_aliases.merge!(JSON.load(File.open(file)))
         end
         @imported_attack_aliases
      end

    end
  end
end

World(Gauntlt::Support::AttackAliasHelper)

