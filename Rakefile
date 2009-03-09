require 'rubygems'
require 'rake'
require 'echoe'

require File.join(File.dirname(__FILE__), 'lib', 'russell')

Echoe.new('russell', '0.0.1') do |p|
  p.description = "Build new proect folders with a simple command"
  p.url = "http://github.com/drcapulet/russell"
  p.author = "Alex Coomans"
  p.email = "alex@alexcoomans.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end


Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }