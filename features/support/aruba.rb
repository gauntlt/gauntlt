require 'aruba/cucumber'

Before do
  @aruba_timeout_seconds = 5  # Add more time for sloooooowww networks
end
