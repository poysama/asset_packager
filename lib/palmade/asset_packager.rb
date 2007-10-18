require 'rubygems'
require 'logger'
require 'fileutils'

unless defined?(PALMADE_DEFAULT_LOGGER)
  PALMADE_DEFAULT_LOGGER = Logger.new($stdout)
  PALMADE_DEFAULT_LOGGER.level = Logger::DEBUG
end

# this library uses the RailsExtensions methods
unless defined?(Palmade::RailsExtensions)
  begin
    re_dir = File.join(File.dirname(__FILE__), "../../../rails_extensions/lib")
    raise LoadError unless File.exists?(re_dir) && File.exists?(File.join(re_dir, 'palmade/rails_extensions.rb'))

    puts "Using local rails_extensions package"
    $:.unshift(re_dir)
    require 'palmade/rails_extensions'
  rescue LoadError
    gem 'rails_extensions'
    require 'palmade/rails_extensions'
  end
end

require File.join(File.dirname(__FILE__), 'jsmin')

require File.join(File.dirname(__FILE__), 'asset_packager/base')
require File.join(File.dirname(__FILE__), 'asset_packager/types')
require File.join(File.dirname(__FILE__), 'asset_packager/package')
require File.join(File.dirname(__FILE__), 'asset_packager/parser')
require File.join(File.dirname(__FILE__), 'asset_packager/manager')

if defined?(ActionController && ActionView && RAILS_ROOT)
  # ok, add RAILS extensions

end
