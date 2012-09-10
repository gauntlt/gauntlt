source :rubygems

gemspec

gem 'debugger', :platforms => 'ruby_19'
gem 'ruby-debug', :platforms => 'ruby_18'

case RUBY_PLATFORM
when /darwin/
  gem "growl"
when /win32/
  gem "notifu"
when /linux/
  gem "libnotify"
end

