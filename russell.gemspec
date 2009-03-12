# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{russell}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alex Coomans"]
  s.date = %q{2009-03-12}
  s.default_executable = %q{russell}
  s.description = %q{russell is a command line utility for setting up new web projects with ease}
  s.email = %q{alex@alexcoomans.com}
  s.executables = ["russell"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["CHANGELOG.rdoc", "README.rdoc", "VERSION.yml", "bin/russell", "lib/russell", "lib/russell/commands", "lib/russell/commands/install_all.rb", "lib/russell/commands/install_config.rb", "lib/russell/commands/install_one.rb", "lib/russell/commands/list_fw.rb", "lib/russell/commands/new_fw.rb", "lib/russell/commands/print_version.rb", "lib/russell/exec.rb", "lib/russell/version.rb", "lib/russell.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/drcapulet/russell}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{russell is a command line utility for setting up new web projects with ease}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
