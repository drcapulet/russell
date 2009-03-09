require "yaml"

module Russell
  module Commands
    class ListFw
      attr_accessor :options
      def initialize(working_path, options)
        #self.options = options
      end
  
      def perform
        @frameworks = YAML::load(File.open("#{Russell.base_directory}/frameworks/manifest.yml"))
        puts ""
        @frameworks.each do |framework|

          @config = YAML::load(File.open("#{Russell.base_directory}/frameworks/#{framework.chomp}.yml"))
          putup = <<END
#{@config['name']}
===================

#{@config['description']}

---------------------------------------------------------------------

END
          puts putup
        end
        
      end
  
# End Class Declaration
    end
  end
end