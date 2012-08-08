module Gauntlt
  module Support
    module ProfileHelper
      def hostname
        raise "No host defined" if @hostname.nil?

        @hostname
      end

      def tcp_ping_ports
        @tcp_ping_ports
      end

      def set_hostname(s)
        @hostname = s
      end

      def set_tcp_ping_ports(s)
        @tcp_ping_ports = s
      end
    end
  end
end

World(Gauntlt::Support::ProfileHelper)

