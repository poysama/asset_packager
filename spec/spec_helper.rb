require 'rubygems'
require 'pp'
require 'logger'

gem 'rspec'

Object.const_set(:SPEC_ROOT, File.dirname(__FILE__))
Object.const_set(:PALMADE_DEFAULT_LOGGER, Logger.new(StringIO.new))

require File.expand_path(File.join(File.dirname(__FILE__), '../lib/palmade/asset_packager'))
