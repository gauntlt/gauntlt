require 'nokogiri'

Given /^the following environment variables:$/ do |table|
  table.hashes.each do |hsh|
    add_to_profile_from_environment( hsh['name'], hsh['environment_variable_name'] )
  end
end

Given /^the following profile:$/ do |table|
  table.hashes.each do |hsh|
    add_to_profile( hsh['name'], hsh['value'] )
  end
end

When /^the file "(.*?)" should contain XML:$/ do |filename, css_selectors|
  css_selectors.hashes.each do |row|
    assert_xml_includes(filename, row['css'])
  end
end

When /^the file "(.*?)" should not contain XML:$/ do |filename, css_selectors|
  css_selectors.hashes.each do |row|
    assert_xml_does_not_include(filename, row['css'])
  end
end
