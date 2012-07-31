When /^I launch a "cookies" attack$/ do
  set_cookies( cookies_for(hostname) )
end

Then /^the following cookies should be received:$/ do |table|
  names = table.hashes.map{|h| h['name'] }
  names.each do |name|
    cookies.any?{|s| s =~ /^#{name}/}.should be_true
    # TODO: check other values in table
  end
end