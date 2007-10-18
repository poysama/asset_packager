module Palmade::AssetPackager::Package
  def find_package(package_name, asset_type = nil)
    sp = sources[package_name]      
    asset_type.nil? ? sp : sp[asset_type] unless sp.nil?
  end

  protected
    def build_package(package_name)
      logger.info("** Package build: #{package_name}")

      sp = sources[package_name]
      sp.keys.each do |asset_type|
        logger.info("=> Asset type: #{package_name}.#{asset_type}")
        sp[asset_type].build
      end
    end

    def delete_package(package_name)
      sp = sources[package_name]
      sp.keys.each do |asset_type|
        sp[asset_type].delete
      end
    end
end

Palmade::AssetPackager::Base.send(:include, Palmade::AssetPackager::Package)
