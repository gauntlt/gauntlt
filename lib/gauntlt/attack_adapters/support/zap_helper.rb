module Gauntlt
    module Support
        module ZapHelper
            def launch_attack
                target = ARGV[0]
                host = ARGV[1].nil? ? 'localhost' : ARGV[1]
                port = ARGV[2].nil? ? '8080' : ARGV[2]

                z = Zap.new :target=>target,
                            :zap=> '~/ZAP/zap.sh',
                            :output=>'~/zap-logfile.txt', # it will log the stdout log from Zap Proxy to a file
                            :daemon => true,
                            :base => 'http://' + host + ':8090'

                z.start :daemon => true, :port => port, :host => host

                while !z.running?
                    sleep(5)
                end

                spidey = z.spider
                spidey.start

                sleep(2)
                if spidey.running?
                    print spidey.status
                end

                z.ascan.start
                print z.alerts.view
                z.shutdown
            end
        end
    end
end

