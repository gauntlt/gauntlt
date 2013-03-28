Warbler::Config.new do |config|
  config.dirs = %w(bin features vendor gem_tasks lib)
  config.includes = FileList["*.rb"] # I don't know why I have to force the
  # ruby file inclusion, but for now it solves the problem described
  # at https://github.com/gauntlt/gauntlt/issues/45
end
