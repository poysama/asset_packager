module Palmade::AssetPackager::Helpers
  module RailsHelper
    def self.setup(configuration)
      if configuration.frameworks.include?(:action_controller) && 
        configuration.frameworks.include?(:action_view)
        require(File.join(ASSET_PACKAGER_LIB_PALMADE_DIR, 'extend/action_controller/base'))
        require(File.join(ASSET_PACKAGER_LIB_PALMADE_DIR, 'extend/action_controller/instance'))
        require(File.join(ASSET_PACKAGER_LIB_PALMADE_DIR, 'extend/action_view/base'))
      end
    end
  end
end
