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
  command.gsub!('<tcp_ping_ports>', tcp_ping_ports)
  run command
end
