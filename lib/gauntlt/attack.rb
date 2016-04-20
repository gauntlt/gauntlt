require 'gauntlt/runtime'

module Gauntlt
  class Attack
    attr_accessor :runtime

    def initialize(path, tags=[], format="", out="")
      self.runtime = Runtime.new(path, tags, format, out)
    end

    def run
      runtime.execute!
    end
  end
end
