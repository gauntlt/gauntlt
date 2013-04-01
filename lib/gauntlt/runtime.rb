require 'cucumber'
require 'cucumber/runtime'
require 'cucumber/cli/main'

module Gauntlt
  class Runtime
    class NoFilesFound < StandardError; end
    class ExecutionFailed < StandardError; end

    attr_accessor :path, :attack_files, :tags

    def initialize(path, tags=[])
      self.path         = path
      self.attack_files = self.class.attack_files_for(path)
      self.tags         = tags

      raise NoFilesFound.new("No files found in path: #{path}") if attack_files.empty?
    end

    def cuke_cli
      args =  attack_files + ['--strict', '--require', self.class.adapters_dir]
      args += ['--tags', tags] unless tags.empty?

      Cucumber::Cli::Main.new(args)
    end

    def cuke_config
      cli.config
    end

    def cuke_runtime
      Cucumber::Runtime.new(cuke_cli.configuration)
    end

    def execute!
      if cuke_cli.execute! # cucumber failed, returning true
        raise ExecutionFailed.new("Bad or undefined attack!")
      else            # cucumber executed successfully, returning false
        true
      end
    end

    class << self
      def cuke_runtime(*args)
        self.new(*args).cuke_runtime
      end

      def attack_files_for(path)
        path.split(' ').map{|p| Dir.glob(p)}.flatten
      end

      def base_dir
        File.expand_path( File.dirname(__FILE__) )
      end

      def adapters_dir
        File.join(base_dir, "attack_adapters")
      end
    end
  end
end