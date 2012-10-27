Before('@slow') do
  @aruba_timeout_seconds = 30
end

if RUBY_PLATFORM == 'java'
  Before do
    @aruba_timeout_seconds = 30
  end
end