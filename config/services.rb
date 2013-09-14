require 'service_manager'

Bundler.with_clean_env do
  Dir.chdir "./vendor/railsgoat" do 
    `bundle install --binstubs`
  end
  
  ServiceManager.define_service "railsgoat" do |s|
    s.start_cmd = "rake db:setup && rails s -p 3000"
    s.loaded_cue = /WEBrick::HTTPServer#start/
    s.cwd = Dir.pwd + "/vendor/railsgoat/"
    s.pid_file = 'railsgoat.pid'
  end
end
