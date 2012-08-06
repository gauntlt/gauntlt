require 'aruba/cucumber'

module Gauntlt
  module Support
    module XmlHelper
      def load_xml_from_file(filename)
        content = ""
        prep_for_fs_check do
          content = IO.read(filename)
        end
        Nokogiri::XML(content)
      end


      def xml_at_css(filename, css)
        xml = load_xml_from_file(filename)
        xml.at_css(css)
      end

      def assert_xml_includes(filename, css)
        raise "#{css} not found in #{filename}" if xml_at_css(filename, css).nil?
      end

      def assert_xml_does_not_include(filename, css)
        raise "#{css} found in #{filename}" unless xml_at_css(filename, css).nil?
      end
    end
  end
end

World(Gauntlt::Support::XmlHelper)