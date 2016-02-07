require 'owasp_zap'

include OwaspZap

target = ARGV[0]
host = ARGV[1].nil? ? 'localhost' : ARGV[1]
port = ARGV[2].nil? ? '8080' : ARGV[2]

z = Zap.new :target=>target, 
    :zap=>"./ZAP_2.4.3/zap.sh",
    :output=>'logfile.txt', # it will log the stdout log from Zap Proxy to a file
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

z.ascan.start # to run active scan
#alert = z.alerts
print z.alerts.view
#z.alerts.view # you can specify one format JSON, XML or HTML.. default JSON.
z.shutdown # stop the proxy
#
# # to disable a specific test
# to_be_disabled = JSON.load(z.policy.all)["policies"].select { |p| p["name"] == "Information gathering" }.first
#
# unless to_be_disabled.nil?
#     z.scanner.disable([to_be_disabled["id"]])
#     end
#
#     # to print the XML report
#     z.xml_report
