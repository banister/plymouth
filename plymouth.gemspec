# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "plymouth"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Mair (banisterfiend)"]
  s.date = "2012-02-08"
  s.description = "FIX ME"
  s.email = "jrmair@gmail.com"
  s.files = [".gemtest", ".gitignore", ".yardopts", "CHANGELOG", "Gemfile", "LICENSE", "README.md", "Rakefile", "lib/plymouth.rb", "lib/plymouth/version.rb", "plymouth.gemspec", "test/test.rb"]
  s.homepage = "http://github.com/banister/plymouth"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "FIX ME"
  s.test_files = ["test/test.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bacon>, ["~> 1.1.0"])
      s.add_runtime_dependency(%q<pry-exception_explorer>, [">= 0"])
    else
      s.add_dependency(%q<bacon>, ["~> 1.1.0"])
      s.add_dependency(%q<pry-exception_explorer>, [">= 0"])
    end
  else
    s.add_dependency(%q<bacon>, ["~> 1.1.0"])
    s.add_dependency(%q<pry-exception_explorer>, [">= 0"])
  end
end
