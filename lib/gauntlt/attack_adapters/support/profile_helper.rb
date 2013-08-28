module Gauntlt
  module Support
    module ProfileHelper
      def gauntlt_profile
        @gauntlt_profile ||= {}
      end

      def add_to_profile(k,v)
        puts "Overwriting profile value for #{k}" if gauntlt_profile.has_key?(k)
        gauntlt_profile[k] = v
      end

      def add_to_profile_from_environment(k,v)
        puts "Overwriting profile with env value for #{k}" if gauntlt_profile.has_key?(k)
        gauntlt_profile[k] = ENV[v]
      end

      def run_with_profile(command_template)
        command = command_template.dup

        gauntlt_profile.each do |name, value|
          command.gsub!( "<#{name}>", value )
        end

        run command
      end
    end
  end
end

World(Gauntlt::Support::ProfileHelper)

