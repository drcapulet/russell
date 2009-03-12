require File.expand_path(File.join(File.dirname(__FILE__), '..', 'version'))
require "yaml"

module Russell
  module Commands
    class InstallConfig
      attr_accessor :options
      def initialize(working_path, options)
        self.options = options
      end
  
      def perform
        begin
          @config = YAML::load(File.open("#{Russell.base_directory}/russell.config"))
          check_config_version(@config)
          read_and_install_with_config(@config)
        rescue => error
          q = ask("No config file exists. Create one?", "Not creating one. Exiting")
          if (q == 1)
            create_config
          end
        end
        
      end
      
      protected 
      
      def ask(question, exit)
        print "#{question} [y/n] "
        input = gets.chomp
        if (input == "y")
          return 1
        else
          puts exit
          exit
        end
      end
      
      def check_config_version(config)
        @version = Russell::Version.read_version
        if config['version'] != @version[:q]
          q = ask("Config file is outdated. Would you like to create a new one?", "")
          if (q == 1)
            create_config
            exit
          else
            exit
          end
        else
          return true
        end
        
      end
      
      def create_config
        config = {}
        @frameworks = YAML::load(File.open("#{Russell.base_directory}/frameworks/manifest.yml"))
        @frameworks.each do |fwname|
          q = ask("Do you want to automatically install the #{fwname.chomp.capitalize} framework using you config file?", "")
          if (q == 1)
            config["#{fwname}"] = true
          else
            config["#{fwname}"] = false
          end
        end
        
        @version = Russell::Version.read_version
        config["version"] = @version[:q]
        
        write_config(config)
      end
      
      def write_config(config)
        wconfig = ""
        config.each do |key, value|
          wconfig = wconfig + "#{key.chomp}: #{value}

"
        end
        File.open( "#{Russell.base_directory}/russell.config", "w" ) do |file| 
          file.puts "#{wconfig}"
        end
      end
      
      def read_and_install_with_config(config)
        command = :install_one
        config.each do |fw, value|
          if value && (fw != "version")
            self.options[:noask] = true
            self.options[:framework] = fw
            do_command(command, options)
          end
        end
      end
      
      def do_command(command, options)
        command_class_name = command.to_s.split(/_/).map{|p| p.capitalize}.join('')
        command_class = eval("::Russell::Commands::#{command_class_name}")
        command_class.new(Dir.getwd, options).perform
      end
      
# End Class Declaration
    end
  end
end

Dir.glob(File.join(Russell.lib_directory, 'russell', 'commands', "*.rb")).each do |file|
  require file
end