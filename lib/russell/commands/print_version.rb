require File.expand_path(File.join(File.dirname(__FILE__), '..', 'version'))

module Russell
  module Commands
    class PrintVersion
      attr_accessor :options
      def initialize(working_path, options)
        #self.options = options
      end
  
      def perform
        # if options[:quiet]
          # The quiet option may make scripting easier
        #  puts ::Russell.version[:string]
        # else
          @version = Russell::Version.read_version
                    
          lines = []
          lines << "Russell #{@version[:string]}"
          lines << "Copyright (c) 2009 Alex Coomans"
          lines << "Released under the MIT License."
          puts lines.join("\n")
        # end
      end
    end
  end
end