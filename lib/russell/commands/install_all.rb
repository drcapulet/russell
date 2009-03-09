module Russell
  module Commands
    class InstallAll
      attr_accessor :options
      def initialize(working_path, options)
        #self.options = options
      end
  
      def perform
        @currentdir = Dir.pwd # Setting the Current Driectory
        # CSS Installer Framework Variables
        @css = {}
        @css["prefix"] = "Would you like to install the"
        @css["response"] = "installing the"
        
        @cssframeworks = YAML::load(File.open("#{Russell.base_directory}/frameworks/manifest.yml"))
        @cssframeworks.each do |framework|
          
          @config = YAML::load(File.open("#{Russell.base_directory}/frameworks/#{framework.chomp}.yml"))
          @css['type'] = check_fw_type(@config)
          q = ask(@css["prefix"], framework.capitalize.chomp, @css["type"], @css["response"])
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
      end
      
      protected
      
      def ask(prefix, question, endr, response)
        print "#{prefix} #{question} #{endr}? [y/n] "
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
        puts ""
        puts "----------------------------"
        puts "To include in your project, add the following to the head section of your file:"
        puts ""
        config['src'].each do |line|
          puts "   #{line}"
        end
        puts ""
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