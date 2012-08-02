require 'English'
# English.rb adds human-readable names for things like $?, $!, etc.:
#   http://www.ruby-doc.org/stdlib-1.9.3/libdoc/English/rdoc/English_rb.html

module Gauntlt
  module Support
    module CliHelper
      def cli_installed?(bin_name)
        `which #{bin_name}` && $CHILD_STATUS.success?
      end

      def ensure_cli_installed(bin)
        raise "#{bin} is not installed or is not in your path" unless cli_installed?(bin)
      end
    end
  end
end
World(Gauntlt::Support::CliHelper)