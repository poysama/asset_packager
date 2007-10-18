require 'fileutils'

# this library uses ActiveSupport methods
unless defined?(ActiveSupport)
  begin
    as_dir = File.join(File.dirname(__FILE__), "../../../activesupport/lib")
    raise LoadError unless File.exists?(as_dir) && File.exists?(File.join(as_dir, 'active_support.rb'))

    puts "Using local active_support package"
    $:.unshift(as_dir)
    require 'active_support'
  rescue LoadError
    require 'rubygems'
    gem 'activesupport'

    require 'active_support'
  end
end

require File.join(File.dirname(__FILE__), 'jsmin')

require File.join(File.dirname(__FILE__), 'asset_packager/base')
require File.join(File.dirname(__FILE__), 'asset_packager/types')
require File.join(File.dirname(__FILE__), 'asset_packager/package')
require File.join(File.dirname(__FILE__), 'asset_packager/parser')
