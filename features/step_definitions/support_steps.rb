Then /^debug$/ do
  require 'debugger'
  debugger
  nil
end

require 'pathname'
Given /^I copy the attack files from the "(.*?)" folder$/ do |folder|
  Dir.glob("./#{folder}/**/*.attack").each do |path|
    name     = Pathname.new(path).basename.to_s
    contents = File.read(path)
    write_file(name, contents)
  end
end

Given /^the following attack files exist:$/ do |table|
  table.hashes.each do |hsh|
      expect([hsh['filename']]).to be_existing_file
  end
end
