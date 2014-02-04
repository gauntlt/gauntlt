require 'service_manager'

Bundler.with_clean_env do
  Dir.chdir "./vendor/gruyere" do 
  end

  ServiceManager.define_service "gruyere" do |s|
    s.start_cmd = "./launch_for_service_manager.sh"
    s.loaded_cue = /Gruyere started.../
    s.cwd = Dir.pwd + "/vendor/gruyere/"
    s.host = "localhost"
    s.port = 8008
  end
end
