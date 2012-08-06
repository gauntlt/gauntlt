# TODO: figure out if there's a way to namespace these step definitions

When /^"nmap" is installed$/ do
  ensure_cli_installed("nmap")
end

When /^the target hostname is "(.*?)"$/ do |host|
  set_hostname host
end

When /^the target tcp_ping_ports are "(.*?)"$/ do |ports|
  set_tcp_ping_ports ports
end

When /^I launch an "nmap" attack with:$/ do |command|
  command.gsub!('<hostname>', hostname)

  if tcp_ping_ports.nil?
    else
      command.gsub!('<tcp_ping_ports>', tcp_ping_ports)
    end

  run command
end

require 'nokogiri'

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