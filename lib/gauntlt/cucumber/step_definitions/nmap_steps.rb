Given /^nmap is installed$/ do
  steps %{
    When I run `which nmap`
    Then the output should contain:
    """
    nmap
    """
  } 
end

When /^I run nmap against the following ports:$/ do |ports|  
  opts = '-p' + ports.hashes.map{ |hsh| hsh['port_number']}.join(',')
  steps %{
    When I run `nmap \"#{hostname}\" #{opts}`
  }
end

When /^I run nmap with OS detection$/ do
  steps %{
    When I run `nmap -sV -p80 -PN \"#{hostname}\"` 
  }

end
