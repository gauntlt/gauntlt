require 'cucumber'
require 'cucumber/runtime'
require 'cucumber/cli/main'
require 'gauntlt/patches/errors.rb'

module Gauntlt

  class Runtime
    class NoFilesFound < StandardError; end
    class ExecutionFailed < StandardError; end

    attr_accessor :path, :attack_files, :tags, :format, :outfile

    def initialize(path, tags=[], format="", outfile="")
      self.path         = path
      self.attack_files = self.class.attack_files_for(path)
      self.tags         = tags
      self.format       = format
      self.outfile      = outfile
      raise NoFilesFound.new("No files found in path: #{path}") if attack_files.empty?
    end

    def cuke_cli
      args =  attack_files + ['--strict', '--no-snippets', '--require', self.class.adapters_dir]
      args += ['--tags', tags] unless tags.empty?
      args += ['--format', format] unless format.nil?
      args += ['--out', outfile] unless outfile.nil?
      Cucumber::Cli::Main.new(args)
    end

    def cuke_config
      cli.config
    end

    def cuke_runtime
      Cucumber::Runtime.new(cuke_cli.configuration)
    end

    def execute!
      cuke_cli.execute! 
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
