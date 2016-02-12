require 'gauntlt/runtime'

module Gauntlt
  class Attack
    attr_accessor :runtime

    def initialize(path, tags=[], format="", outfile="")
      self.runtime = Runtime.new(path, tags, format, outfile)
    end

    def run
      runtime.execute!
    end
  end
end
