module Gauntlt
  module Support
    module ProfileHelper
      def hostname
        raise "No host defined" if @hostname.nil?

        @hostname
      end

      def target_url
        raise "No target URL defined" if @target_url.nil?

        @target_url
      end

      def tcp_ping_ports
        @tcp_ping_ports
      end

      def set_hostname(s)
        @hostname = s
      end

      def set_target_url(s)
        @target_url = s
      end

      def set_tcp_ping_ports(s)
        @tcp_ping_ports = s
      end
    end
  end
end

World(Gauntlt::Support::ProfileHelper)

