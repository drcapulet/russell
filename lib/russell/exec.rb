# Handles the brunt work, not not the commands.
# Sets up the option parsing and actions when
# a flag is triggered

require 'optparse' 
require 'rdoc/usage'
require 'ostruct'

module Russell
  module Exec
    class Russell
      
      attr_accessor :args, :options, :opts
      
      # Takes the arugments from the command-line and sets up an empty hash. Then it continues on to parse!
      def initialize(args)
        self.args = args
        self.options = {}
        parse!
      end
      
      # Runs the entire program. Run after parse! has completed
      def run!
        perform!
      end
      
      protected
      
      def perform!
        if options[:command]
          do_command(options[:command])
        else
          puts self.opts
        end
      end
      
      def parse!
        self.opts = OptionParser.new(&method(:set_opts))
        self.opts.parse!(self.args)    
        # if self.args.size > 0
        #   self.options[:project_name] = trim_trailing_separator(self.args.shift)
        # end
        if self.args.size == 0
        end
        self.options[:command] ||= :install_all
        self.options[:environment] ||= :production
        self.options[:framework] ||= :f960
        self.options[:project_type] ||= :stand_alone
      end
      
      # Sets up all of the options
      def set_opts(opts)
        opts.banner = <<END
Usage: russell [options] [project]

Options:
END
        opts.on('-c', '--config', 'Read the config file from the user\'s home directory') do
          self.options[:config] = true
          self.options[:command] = :install_config
        end

        opts.on('-f FRAMEWORK', '--framework FRAMEWORK', 'Set up a new project using the specified framework.') do |framework|
          self.options[:command] = :install_one
          self.options[:framework] = framework
        end
        
        opts.on('-l', '--list', 'List all available frameworks') do
          self.options[:command] = :list_fw
        end
        
        opts.on('-n', '--new', 'Adds a new framework to the central system') do
          self.options[:command] = :new_fw
        end
        
        opts.on_tail("-?", "-h", "--help", "Show this message") do
          puts opts
          exit
        end
        
        opts.on_tail("-v", "--version", "Print version") do
          self.options[:command] = :print_version
        end
      end
      
      def do_command(command)
        command_class_name = command.to_s.split(/_/).map{|p| p.capitalize}.join('')
        command_class = eval("::Russell::Commands::#{command_class_name}")
        command_class.new(Dir.getwd, options).perform
      end
      
    end
  end
end

Dir.glob(File.join(File.dirname(__FILE__), 'commands', "*.rb")).each do |file|
  require file
end