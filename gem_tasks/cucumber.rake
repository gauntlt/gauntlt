require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.fork = false

  if RUBY_PLATFORM == "java"
    t.cucumber_opts = "features --tags ~@skip-on-jruby"
  end
end
