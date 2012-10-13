$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__))

require 'gauntlt'
require 'tmf'

include TMF

# adapted from:
# http://apidock.com/rails/v3.2.8/Kernel/with_warnings
# http://apidock.com/rails/v3.2.8/Kernel/silence_warnings
def silently
  old_verbose, $VERBOSE = $VERBOSE, nil
  yield
ensure
  $VERBOSE = old_verbose
end

def const_stub(o, opts)
  old_val = o.const_get(opts[:name])
  silently { o.const_set(opts[:name], opts[:value]) }
  yield
ensure
  silently{ o.const_set(opts[:name], old_val) }
end