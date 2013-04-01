require 'gauntlt/runtime'

module Gauntlt
  class Attack
    attr_accessor :runtime

    def initialize(path, tags=[])
      self.runtime = Runtime.new(path, tags)
    end

    def run
      runtime.execute!
    end
  end
end