module Palmade::AssetPackager
  module Helpers
    include Palmade::HelperHelper

    helper :RailsHelper, File.join(ASSET_PACKAGER_LIB_PALMADE_DIR, 'asset_packager/helpers/rails_helper')
    helper :MerbHelper, File.join(ASSET_PACKAGER_LIB_PALMADE_DIR, 'asset_packager/helpers/merb_helper')
  end
end
