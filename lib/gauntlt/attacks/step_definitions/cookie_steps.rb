When /^I send a GET request to the hostname$/ do
  set_cookies( cookies_for(hostname) )
end

Then /^the following cookies should be received:$/ do |table|
  names = table.hashes.map{|h| h['name'] }
  names.each do |name|
    cookies.any?{|s| s =~ /^#{name}/}.should be_true 
  end
end