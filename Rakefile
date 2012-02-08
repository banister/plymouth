$:.unshift 'lib'

PROJECT_NAME = "plymouth"

require "#{PROJECT_NAME}/version"

CLASS_NAME = Plymouth

require 'rake/clean'
require 'rake/gempackagetask'

CLOBBER.include("**/*~", "**/*#*", "**/*.log", "**/*.o")
CLEAN.include("ext/**/*.log", "ext/**/*.o",
              "ext/**/*~", "ext/**/*#*", "ext/**/*.obj", "**/*#*", "**/*#*.*",
              "ext/**/*.def", "ext/**/*.pdb", "**/*_flymake*.*", "**/*_flymake")

def apply_spec_defaults(s)
  s.name = PROJECT_NAME
  s.summary = "FIX ME"
  s.version = CLASS_NAME::VERSION
  s.date = Time.now.strftime '%Y-%m-%d'
  s.author = "John Mair (banisterfiend)"
  s.email = 'jrmair@gmail.com'
  s.description = s.summary
  s.require_path = 'lib'
  s.add_development_dependency("bacon","~>1.1.0")
  s.homepage = "http://github.com/banister/#{PROJECT_NAME}"
  s.has_rdoc = 'yard'
  s.add_dependency('pry-exception_explorer')
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n")
end

desc "Run tests"
task :test do
  sh "bacon -Itest -rubygems test.rb -q"
end

desc "generate gemspec"
task :gemspec => "ruby:gemspec"

namespace :ruby do
  spec = Gem::Specification.new do |s|
    apply_spec_defaults(s)
    s.platform = Gem::Platform::RUBY
  end

  Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_zip = false
    pkg.need_tar = false
  end

  desc  "Generate gemspec file"
  task :gemspec do
    File.open("#{spec.name}.gemspec", "w") do |f|
      f << spec.to_ruby
    end
  end
end

desc "Show version"
task :version do
  puts "Plymouth version: #{Plymouth::VERSION}"
end

desc  "Generate gemspec file"
task :gemspec => "ruby:gemspec"

desc "build all platform gems at once"
task :gems => [:clean, :rmgems, "ruby:gem"]

task :gem => [:gems]

desc "remove all platform gems"
task :rmgems => ["ruby:clobber_package"]

desc "build and push latest gems"
task :pushgems => :gems do
  chdir("./pkg") do
    Dir["*.gem"].each do |gemfile|
      sh "gem push #{gemfile}"
    end
  end
end

