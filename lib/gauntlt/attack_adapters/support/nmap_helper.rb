require 'aruba'

module Gauntlt
  module Support
    module NmapHelper
      def run_nmap_attack(host, opts)
        args = opts.map{|k,v| "#{k} #{v}"}

        command = "nmap #{args.join(' ')} #{host}"

        # run is from aruba
        run command
      end
    end
  end
end

World(Gauntlt::Support::NmapHelper)