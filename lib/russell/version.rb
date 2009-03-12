module Russell
  module Version
    # Returns a hash representing the version.
    # The :major, :minor, and :teeny keys have their respective numbers.
    # The :string key contains a human-readable string representation of the version.
    # If checked out from Git,
    # the :rev key will have the revision hash.
    #
    # This method swiped from Haml and then modified, some credit goes to Nathan Weizenbaum
    # I (alex) then swiped it from Compass - so thanks there!
    attr_reader :major, :minor, :patch
    
    def scope(file) # :nodoc:
      File.join(File.dirname(__FILE__), '..', '..', file)
    end
        
    def read_version
      yaml = YAML::load(File.open("#{Russell.base_directory}/VERSION.yml"))
      @major = (yaml['major'] || yaml[:major]).to_i
      @minor = (yaml['minor'] || yaml[:minor]).to_i
      @patch = (yaml['patch'] || yaml[:patch]).to_i
            
      @version = {:string => "#{@major}.#{@minor}.#{@patch}"}
      @version[:q] = "#{@major}.#{@minor}.#{@patch}"
      
      if r = revision_from_git
        @version[:rev] = r
        @version[:string] << " [#{r[0...7]}]"
      end
      @version
    end
    
    protected
    

    def revision_from_git
      if File.exists?(scope('.git/HEAD'))
        rev = File.read(scope('.git/HEAD')).strip
        if rev =~ /^ref: (.*)$/
          rev = File.read(scope(".git/#{$1}")).strip
        end
      end
    end

    module_function :read_version, :revision_from_git, :scope
    
  end
end
