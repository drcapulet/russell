require "yaml"

module Russell
  module Commands
    class InstallOne
      attr_accessor :options
      def initialize(working_path, options)
        self.options = options
      end
  
      def perform
        framework = self.options[:framework]
        @currentdir = Dir.pwd # Setting the Current Driectory
        # CSS Installer Framework Variables
        @css = {}
        @css["prefix"] = "You are going to install the"
        @css["response"] = "installing the"
        
        begin
          @config = YAML::load(File.open("#{Russell.base_directory}/frameworks/#{framework.chomp}.yml"))
        rescue
          puts "The specifiec framework is not available! Exiting!"
          exit
        end
        
        @css["type"] = check_fw_type(@config)
        
        if (self.options[:noask] == false)
          q = ask(@css["prefix"], framework.capitalize.chomp, @css["type"], @css["response"])
        else
          q = 1
          puts "Installing the #{framework} framework"
          puts "======================================"
        end
        
        if (q == 1)
          @config['manifest'].each do |file|
            puts "  [add] - #{file}"
          end
          show_src_code(@config)
          if @config['inside']
            cmd = `cp -R #{Russell.base_directory}/frameworks/#{framework.chomp} #{@currentdir}/#{framework}`  
          else
            cmd = `cp -R #{Russell.base_directory}/frameworks/#{framework.chomp}/* #{@currentdir}`
          end
        end
      end
      
      protected
      
      def ask(prefix, question, endr, response)
        print "#{prefix} #{question} #{endr}. Continue? [y/n] "
        input = gets.chomp
        if (input == "y")
          puts "#{response.capitalize.to_s} #{question.to_s} #{endr}"
          return 1
        elsif (input == "n")
          puts "Not #{response} #{question} #{endr}"
          return 0
        else
          puts "Error!"
          exit
        end
      end
      
      def show_src_code(config)
        if config['src']
          puts ""
          puts "To include in your project, add the following to the head section of your file:"
          config['src'].each do |line|
            puts "   #{line}"
          end
          puts ""
          puts ""
        end
      end
      
      def check_fw_type(config)
        if (config['type'] == "CSS")
          return "CSS Framework"
        elsif (config['type'] == "JS")
          return "Javascript Framework"
        else
          return ""
        end
      end

# End Class Declaration      
    end
  end
end