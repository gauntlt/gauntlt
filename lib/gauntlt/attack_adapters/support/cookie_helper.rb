require 'curb'

module Gauntlt
  module Support
    module CookieHelper
      def cookies_for(url)
        [].tap do |returner|
          c = Curl::Easy.perform(url) do |curl|
            curl.follow_location = true
            curl.enable_cookies = true

            curl.on_header do |header|
              returner << "#{$1}=#{$2}" if header =~ /^Set-Cookie: ([^=]+)=([^;]+;)/
            end
          end
        end
      end

      def cookies
        raise "No cookies set" if @cookies.nil?

        @cookies
      end

      def set_cookies(a)
        @cookies = a
      end
    end
  end
end

World(Gauntlt::Support::CookieHelper)