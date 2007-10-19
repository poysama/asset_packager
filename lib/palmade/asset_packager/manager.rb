class Palmade::AssetPackager::Manager
  attr_accessor :logger

  def initialize(base, name, asset_root, logger)
    @ap = base
    @package_name = name
    @asset_root = asset_root
    @logger = logger
    @assets = { }
  end

  def [](asset_type)
    @assets[asset_type]
  end

  def inherit_assets(other_am)
    @assets.keys.each do |asset_type|
      @assets[asset_type].include_asset(other_am[asset_type]) unless other_am[asset_type].nil?
    end
  end

  def update_assets_from_yml(pdata)
    # asset types can be javascripts, stylesheets, images
    pdata.keys.each do |asset_type|
      update_asset(asset_type, pdata[asset_type])
    end
  end

  def update_asset(asset_type, *source)
    klass = @ap.get_asset_type_class(asset_type)
    unless klass.nil?
      @assets[asset_type] ||= klass.new(@ap, @package_name, @asset_root, @logger)
      @assets[asset_type].update_asset(*source)
    end
  end

  def post_parse
    @assets.values.each { |apt| apt.post_parse }
  end

  def build_package
    @assets.values.each do |apt|
      logger.info("=> Asset type: #{@package_name}.#{apt.asset_type}")
      apt.build
    end
  end

  def destroy_package
    @assets.values.each do |apt|
      apt.destroy
    end
  end
end
