module Gauntlt
  module Support
    module CookieHelper
      def cookies_for_last_curl_request
        raise "no curl output found!" unless @raw_curl_response

        @raw_curl_response.scan(/^Set-Cookie:.+$/).map do |header|
          cookie_data    = header.gsub(/^set-cookie: /i,'')
          cookie         = {}
          parts          = cookie_data.split(/;/).reject{ |c| c.empty? }
          cookie[:name]  = parts[0].split(/=/)[0]
          rest           = parts[0].split(/=/).drop(1)
          cookie[:value] = rest.join('=')

          parts.drop(1).inject(cookie) do |inj,p|
            stripped = p.strip
            k, v     = stripped.split('=').map(&:downcase)

            case k
            when 'expires'
              inj[:expires]  = v
            when 'max-age'
              inj[:max_age]  = v
            when 'secure'
              inj[:secure]   = "true"
            when 'httponly'
              inj[:httponly] = "true"
            when 'samesite'
              inj[:samesite] = v
            else
              inj[k.to_sym]  = v
            end

            inj
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