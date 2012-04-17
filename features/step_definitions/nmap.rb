When /^echo is run$/ do 
  @output = `echo "#{@hostname}"`
  puts "#{@output}"

end
When /^nmap is run against the hostname$/ do
  run pending # express the regexp above with the code you wish you had
end
Then /^I expect to see output containing google$/ do
  puts @output
end

