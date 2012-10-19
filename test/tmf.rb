# Copyright (c) 2012 Mani Tadayon
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the “Software”), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# The Software shall be used for Good, not Evil.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module TMF
  class ExpectationNotMet < StandardError
    def initialize(o, verb, value)
      super("Expected #{o} #{verb} #{value}")
    end
  end

  def assert(a, opts)
    opts.each do |meth, val|
      a.send(meth, val) || raise( ExpectationNotMet.new(a, meth, val) )
    end && true
  end

  def stub(o, opts)
    opts[:method] = opts[:spy] if opts.has_key?(:spy)
    old_method = o.respond_to?(opts[:method]) ? o.method(opts[:method]).to_proc : nil

    called = false
    o.singleton_class.send(:define_method, opts[:method]) do |*args|
      called = 1
      opts[:error] ? raise(opts[:error]) : opts[:return]
    end

    yield if block_given?
  ensure
    raise ExpectationNotMet.new(o, 'to receive', opts[:method]) if opts[:spy] && !called

    old_method ?
      o.singleton_class.send(:define_method, opts[:method], old_method) :
      o.singleton_class.send(:undef_method, opts[:method])
  end
end