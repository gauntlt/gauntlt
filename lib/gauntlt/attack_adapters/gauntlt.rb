When /^the target hostname is "(.*?)"$/ do |host|
  set_hostname host
end

When /^the target URL is "(.*?)"$/ do |u|
  set_target_url u
end
