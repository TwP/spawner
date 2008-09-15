
require 'optparse'
require File.expand_path(
    File.join(File.dirname(__FILE__), %w[.. spawner]))

# The main application for the "spawner" command line tool.
#
class Spawner::Main

  # Convenience method for creating and running.
  #
  def self.run( args )
    new.run( args )
  end

  # The configuration options parsed from the command line arguments
  attr_reader :config

  # Initializes a new main object.
  #
  def initialize
    @config = {}
  end

  # Parse the given command line _args_ and run the command according to
  # the arguments passed in.
  #
  def run( args )
    parse(args)
    args << config

    spawner = ::Spawner.new(*args)
    Signal.trap('INT') { spawner.stop }

    count = config[:spawn] || 1
    puts "starting #{count} child processes (Ctrl-C to quit)"

    spawner.start
    spawner.join

    puts 'sleeping for 7 seconds'
    sleep 7

    puts 'finished'
  end

  # Parse the given array of command line _args_ and return the command to
  # run.
  #
  def parse( args )
    opts = OptionParser.new
    opts.banner = 'Usage: spawner [options] command'

    opts.separator ''
    opts.on('-s', '--spawn NUMBER', Integer,
            'number of child processes to spawn') {|s| config[:spawn] = s}
    opts.on('-p', '--pause SECONDS', Float,
            'time to wait before re-spawning') {|p| config[:pause] = p}

    opts.separator ''
    opts.on('--stdin FILENAME', String,
            'child process reads input from here') {|fn| config[:stdin] = fn}
    opts.on('--stdout FILENAME', String,
            'child process writes output to here') {|fn| config[:stdout] = fn}
    opts.on('--stderr FILENAME', String,
            'child process writes errors to here') {|fn| config[:stderr] = fn}

    opts.separator ''
    opts.separator 'common options:'

    opts.on_tail( '-h', '--help', 'show this message' ) do
      puts opts
      exit
    end
    opts.on_tail( '--version', 'show version' ) do
      puts "spawner #{::Spawner::VERSION}"
      exit
    end

    opts.parse! args
    if args.empty?
      puts opts
      abort "missing command"
    end
  end

end  # class Spawner::Main

# EOF
