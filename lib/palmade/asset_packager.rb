require 'rubygems'
require 'logger'
require 'fileutils'

ASSET_PACKAGER_LIB_PALMADE_DIR = File.dirname(__FILE__)
ASSET_PACKAGER_LIB_DIR = File.join(ASSET_PACKAGER_LIB_PALMADE_DIR, '..')
ASSET_PACKAGER_ROOT_DIR = File.join(ASSET_PACKAGER_LIB_DIR, '..')

unless defined?(PALMADE_DEFAULT_LOGGER)
  PALMADE_DEFAULT_LOGGER = Logger.new($stdout)
  PALMADE_DEFAULT_LOGGER.level = Logger::DEBUG
end

unless defined?(Palmade::VERSION)
  PALMADE_EXT_RELATIVE_DIR = File.join(ASSET_PACKAGER_ROOT_DIR, '../palmade_extensions')
  if File.exists?(File.join(PALMADE_EXT_RELATIVE_DIR, 'lib/palmade/palmade_extensions.rb'))
    require File.join(PALMADE_EXT_RELATIVE_DIR, 'lib/palmade/palmade_extensions')
  else
    gem 'palmade_extensions'
    require 'palmade/palmade_extensions'
  end
end

require File.join(File.dirname(__FILE__), 'jsmin')

module Palmade
  module AssetPackager
    COMPILED = 1
    COMPILED_Z = 2
  end
end

require File.join(File.dirname(__FILE__), 'asset_packager/base')
require File.join(File.dirname(__FILE__), 'asset_packager/asset')
require File.join(File.dirname(__FILE__), 'asset_packager/types')
require File.join(File.dirname(__FILE__), 'asset_packager/package')
require File.join(File.dirname(__FILE__), 'asset_packager/parser')
require File.join(File.dirname(__FILE__), 'asset_packager/manager')

if defined?(ActionController) && defined?(ActionView) && defined?(RAILS_ROOT)
  # ok, add RAILS extensions
  require File.join(File.dirname(__FILE__), 'rails_packager')
  require File.join(File.dirname(__FILE__), 'extend/action_controller/base')
  require File.join(File.dirname(__FILE__), 'extend/action_controller/instance')
  require File.join(File.dirname(__FILE__), 'extend/action_view/base')
end
