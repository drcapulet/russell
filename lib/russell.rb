# Sets up the basic global stuff and loads in the version.rb file

# Load the Version Module Lib file so that the arugment -v works easier
require File.expand_path(File.join(File.dirname(__FILE__), 'russell', 'version'))

module Russell
  extend Russell::Version
  # Defines the base russel directory. Refers to the russell
  # directory above the bin and lib directories
  # 
  def base_directory
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end
  def lib_directory
    File.expand_path(File.join(File.dirname(__FILE__)))
  end
  module_function :base_directory, :lib_directory
end

