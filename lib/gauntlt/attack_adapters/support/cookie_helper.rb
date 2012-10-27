module Gauntlt
  module Support
    module CookieHelper
      def cookies_for_last_curl_request
        raise "no curl output found!" unless @raw_curl_response

        @raw_curl_response.scan(/^Set-Cookie:.+$/).map do |header|
          "#{$1}=#{$2}" if header =~ /^Set-Cookie: ([^=]+)=([^;]+;)/
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