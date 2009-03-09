require "yaml"

module Russell
  module Commands
    class NewFw
      attr_accessor :options
      def initialize(working_path, options)
        self.options = options
      end
  
      def perform
        @currentdir = Dir.pwd # Setting the Current Driectory
        # CSS Installer Framework Variables
        fw = {}
        
        question = "You are going to install a new framework to russell"
        #q = ask(question)
        
        print "What would you like this framework to be named? "
        fw['name'] = gets.chomp
        
        print "Where is the base folder located? "
        fw['dir'] = gets.chomp
        
        print "What would you like the description for the project to be? "
        fw['description'] = gets.chomp
        
        print "Do you want the files to be placed in their own directory? [y/n] "
        input = gets.chomp
        if (input == "y")
          fw['inside'] = true
        else
          fw['inside'] = false
        end
        
        puts "Generating Manifest"
        fwdir = fw['dir']
        files = []
        

  
        Dir.chdir(fwdir)
        Dir["**/**"].each do |file|
          next if File.directory?(file)
          #puts " #{file}"
          files << file
        end

        manifest = ""
        files.each do |file|
          manifest = manifest + "
    #{file}
"
        end
        
        mancontent = "
name:
  #{fw['name']}

description:
  #{fw['description']}
  
inside: #{fw['inside']}

manifest: 
#{manifest}

"
        
        File.open("#{Russell.base_directory}/frameworks/#{fw['name']}.yml", "w") { |f| f.write(mancontent) }
        
        fwmanifest = YAML::load(File.open("#{Russell.base_directory}/frameworks/manifest.yml"))
        fwmani = ""
        fwmanifest.each do |fwn|
          fwmani = fwmani + "  
#{fwn}"
        end
        fwmani = fwmani + "    
   
#{fw['name']}"
        File.open("#{Russell.base_directory}/frameworks/manifest.yml", "w") { |f| f.write(fwmani) }

      end
      
      protected
      
      def ask(question)
        print "#{question}. Continue? [y/n] "
        input = gets.chomp
        if (input == "y")
          return 1
        elsif (input == "n")
          puts "Qutting"
          exit
        else
          puts "Error!"
          exit
        end
      end
# End Class Declaration
    end
  end
end