Given /^the target hostname is "(.*?)"$/ do |host|
	# ultimately settings like hostname will be read 
  # from a profile stored as xml, YAML, etc.
  # but for now, we are passing settings explicitly
	set_hostname host
end

