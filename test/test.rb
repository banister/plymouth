direc = File.dirname(__FILE__)

require 'rubygems'
require "#{direc}/../lib/plymouth"
require 'bacon'

puts "Testing plymouth version #{Plymouth::VERSION}..." 
puts "Ruby version: #{RUBY_VERSION}"

describe Plymouth do
end

