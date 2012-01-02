require 'rubygems'
require 'bundler/setup'

require 'logger'
require 'action_controller'
require 'action_view'
require 'ostruct'

Object.const_set(:PALMADE_DEFAULT_LOGGER, Logger.new(StringIO.new))

require 'palmade/asset_packager'
