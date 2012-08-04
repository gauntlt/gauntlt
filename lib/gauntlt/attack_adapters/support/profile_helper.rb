module Gauntlt
  module Support
    module ProfileHelper
      def hostname
        raise "No host defined" if @hostname.nil?

        @hostname
      end

      def set_hostname(s)
        @hostname = s
      end
    end
  end
end

World(Gauntlt::Support::ProfileHelper)