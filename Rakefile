require 'rubygems'
require 'rake'

require File.join(File.dirname(__FILE__), 'lib', 'russell')

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "russell"
    s.summary = "russell is a command line utility for setting up new web projects with ease"
    s.email = "alex@alexcoomans.com"
    s.homepage = "http://github.com/drcapulet/russell"
    s.description = "russell is a command line utility for setting up new web projects with ease"
    s.authors = ["Alex Coomans"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end


Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }