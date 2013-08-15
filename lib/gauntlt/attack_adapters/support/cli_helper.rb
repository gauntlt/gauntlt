require 'aruba/cucumber'

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

      def ensure_shell_variable_set(shell_variable)
        raise "#{shell_variable} is not set" unless shell_variable_exists?(shell_variable)
      end

      def get_shell_variable(shell_variable)
        ENV[shell_variable]
      end

      def shell_variable_exists?(shell_variable)
        path = get_shell_variable(shell_variable)
        File.exists?(path) if path
      end

  
    end
  end
end

World(Gauntlt::Support::CliHelper)

Before('@slow') do
  @aruba_timeout_seconds = 30
end
