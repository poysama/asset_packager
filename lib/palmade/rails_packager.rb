module Palmade; end

class Palmade::RailsPackager
  class Error < StandardError; end
  class ConfigNotFound < Error; end
  class UnknownCommand < Error; end

  attr_accessor :logger

  def initialize(rails_root)
    @rails_root = rails_root
    @logger ||= PALMADE_DEFAULT_LOGGER
  end

  def default_conf_file
    File.join(@rails_root, 'config/asset_packages.yml')
  end

  def default_conf_dir
    File.join(@rails_root, 'config/asset_packages')
  end
  
  def build
    logger.info("** Start building asset files")
    @asset_packager.build
  end

  def rebuild
    delete
    build
  end
  
  def delete
    logger.info("** Start deleting built asset files")
    @asset_packager.delete
  end

  def rails_attach
  end

  def run(argv)
    logger.debug("** Initialize AssetPackager::Base")
    @asset_packager = Palmade::AssetPackager::Base.new(@logger)
    @asset_packager.asset_root = File.join(@rails_root, 'public')

    if File.exists?(default_conf_file)
      @asset_packager.build_package_list(default_conf_file)
    elsif File.exists?(default_conf_dir)
      @asset_packager.build_package_list(default_conf_dir, true)
    else
      raise ConfigNotFound, "Default configuration file(s) not found"
    end

    case argv[0]
    when 'build', nil
      build
    when 'rebuild'
      rebuild
    when 'delete'
      delete
    when 'rails_attach'
      rails_attach
    else
      raise UnknownCommand, "Unknown command (#{ARGV[0]})"
    end
  end
end
