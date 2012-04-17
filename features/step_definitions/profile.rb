Given /^the hostname in the profile\.xml$/ do
	@hostname = "google.com"  

end

Then /^the hostname should be google dot com$/ do
  puts @hostname
end
