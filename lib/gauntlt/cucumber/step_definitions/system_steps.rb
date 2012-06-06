Given /^"(.*?)" is installed$/ do |bin|
  raise "#{bin} is not installed or is not in your path" unless installed?(bin)
end