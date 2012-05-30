require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.fork = false
end