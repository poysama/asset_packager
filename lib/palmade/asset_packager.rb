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

module Palmade
  module AssetPackager
    autoload :AssetBase, File.join(ASSET_PACKAGER_LIB_PALMADE_DIR, 'asset_packager/asset_base')
    autoload :Jsmin, File.join(ASSET_PACKAGER_LIB_PALMADE_DIR, 'asset_packager/jsmin')
    autoload :Types, File.join(ASSET_PACKAGER_LIB_PALMADE_DIR, 'asset_packager/types')
    autoload :Base, File.join(ASSET_PACKAGER_LIB_PALMADE_DIR, 'asset_packager/base')
    autoload :Helpers, File.join(ASSET_PACKAGER_LIB_PALMADE_DIR, 'asset_packager/helpers')
    autoload :Manager, File.join(ASSET_PACKAGER_LIB_PALMADE_DIR, 'asset_packager/manager')
    autoload :RailsPackager, File.join(ASSET_PACKAGER_LIB_PALMADE_DIR, 'asset_packager/rails_packager')
    
    COMPILED = 1
    COMPILED_Z = 2
  end
end
